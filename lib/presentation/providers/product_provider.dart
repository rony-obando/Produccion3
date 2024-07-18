import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/Componente.dart';
import 'package:frontendapp/config/domain/entities/Producto.dart';
import 'package:frontendapp/config/domain/entities/demanda.dart';
import 'package:frontendapp/config/domain/entities/rama.dart';
import 'package:frontendapp/config/domain/entities/union.dart';
import 'package:frontendapp/config/domain/entities/viewunion.dart';
import 'package:graphview/GraphView.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductProvider extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;
  String _name = '';
  int _cantidad = 0;
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> unions = [];
  List<Map<String, dynamic>> componentes = [];
  List<Componente> x = [];
  List<String> _nombres = [];
  List<Componente> todo = [];
  List<Componente> comps = [];
  List<Union> unn = [];
  List<Producto> prd = [];
  // ignore: non_constant_identifier_names
  List<ViewUnion> VU = [];
  String _selectedUV = '';
  String _selectedUV1 = '';
  Graph _graph = Graph()..isTree = true;
  final SugiyamaConfiguration _builder = SugiyamaConfiguration();
  bool isLoading = true;
  // ignore: non_constant_identifier_names
  int _IdProducto = 0;
  int _demanda = 1000;
  String _idUsuario = '';

  ProductProvider() {
    fetchProducts();
  }

  void setSelectedItem({item, item1}) {
    _selectedUV = item ?? _selectedUV;
    _selectedUV1 = item1 ?? _selectedUV1;
    notifyListeners();
  }

  final TransformationController transformationController =
      TransformationController();

  void resetTransformation() {
    transformationController.value = Matrix4.identity();
    notifyListeners();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  String _text1 = '';

  String get text1 => _text1;
  Graph get graph => _graph;
  SugiyamaConfiguration get builder => _builder;
  // ignore: non_constant_identifier_names
  int get IdProducto => _IdProducto;
  int get cantidad => _cantidad;
  String get nombre => _name;
  String get selectedUV => _selectedUV;
  String get selectedUV1 => _selectedUV1;
  List<String> get nombres => _nombres;
  int get demanda => _demanda;
  String get idUsuario => _idUsuario;

  Future<void> setDemanda(demanda) async {
    _demanda = demanda ?? _demanda;
    notifyListeners();
  }


  String getdemandaprom(){
    String demsp='';
    for(int i =0; i<dems.length; i++){
      if(i==0){
        demsp = '${dems[i].resultado}'; 
      }else{
        demsp = '$demsp + ${dems[i].resultado}'; 
      }
    }
    demsp ='$demsp / ${dems.length}';

    demsp = '$demsp = ${dems.map((e) => e.resultado).reduce((value, element) => value+element)/dems.length}';
    return demsp;
  }

  // ignore: non_constant_identifier_names
  Future<void> setGraphProps(IdProducto) async {
    if (IdProducto != null) {
      for (int i = 0; i < comps.length; i++) {
        comps[i].subcomponentes = [];
      }
      _nombres = [];
      _graph = Graph()..isTree = true;
      resetTransformation();
      _IdProducto = IdProducto;
      todo = fetchComponentsOfProduct(IdProducto);
      x = [];
      cloneComponentTree(todo, x, null, prd);
      _builder
        //..siblingSeparation = (50)
        ..levelSeparation = (100)
        // ..subtreeSeparation = (100)
        ..nodeSeparation = (15)
        ..orientation = (SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM);

      notifyListeners();
    }
  }

  Future<void> setUsuario(idusuario) async {
    _idUsuario = idusuario?? _idUsuario;
  }

  Future<void> setProductprops({nombre, cantidad, text1}) async {
    _name = nombre ?? _name;
    _cantidad = cantidad ?? _cantidad;
    _text1 = text1?? _text1;
    notifyListeners();
  }

  bool noUnions(int id){
    Producto p = prd.firstWhere((element) => element.idProducto==id);
    return unn.where((element) => element.PadreEsProducto && element.idPadre==p.idProducto).isEmpty;
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      
      final responseunion = await client.from('Union').select().eq('IdUsuario', _idUsuario);
      final response = await client.from('Producto').select().eq('IdUsuario', _idUsuario);
      final responsecomponente = await client.from('Componente').select().eq('IdUsuario', _idUsuario);

      products = List<Map<String, dynamic>>.from(response);
      unions = List<Map<String, dynamic>>.from(responseunion);
      componentes = List<Map<String, dynamic>>.from(responsecomponente);

      final data = responsecomponente as List;
      comps = data.map((json) => Componente.fromJson(json)).where((element) => element.idUsuario == _idUsuario).toList();
      final data1 = responseunion as List;
      unn = data1.map((json) => Union.fromJson(json)).where((element) => element.idUsuario == _idUsuario).toList();
      final data2 = response as List;
      prd = data2.map((json) => Producto.fromJson(json)).where((element) => element.idUsuario == _idUsuario).toList();
      _selectedUV = prd.first.nombre;
      _selectedUV1 = comps.first.nombre;
      parentNodeMap.clear();

      setUnions();
      // ignore: empty_catches
    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    final response = await client.from('Producto').delete().match({'id': id});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> updateProduct(int id, String nombre, int cantidad) async {
    final response = await client
        .from('Producto')
        .update({'nombre': nombre, 'cantidad': cantidad}).match({'id': id});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> addProduct(String nombre, int cantidad) async {
    final response = await client
        .from('Producto')
        .insert({'nombre': nombre, 'cantidad': cantidad, 'IdUsuario': _idUsuario});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  void cloneComponentTree(List<Componente> source, List<Componente> destination,
      Componente? anterior, List<Producto>? producto) {
   // parentNodeMap.clear();
    for (Componente original in source) {
      Componente cloned = original.cloneWithoutSubcomponents();
      destination.add(cloned);

      if (producto != null&& producto.isNotEmpty) {
        Node node1 = Node.Id(producto
            .firstWhere((element) => element.idProducto == _IdProducto)
            .nombre);
        Node node2 = Node.Id(original.nombre);
        // nombres.add('${original.nombre}+${}');
        if (parentNodeMap[node2] == null) {
          parentNodeMap[node2] = [];
        }
        parentNodeMap[node2]?.add(node1);
        _graph.addEdge(node1, node2, paint: Paint()..color = Colors.black);
      } else {
        Node node1 = Node.Id(anterior?.nombre);
        Node node2 = Node.Id(original.nombre);
        if (parentNodeMap[node2] == null) {
          parentNodeMap[node2] = [];
        }
        parentNodeMap[node2]?.add(node1);

        _graph.addEdge(node1, node2, paint: Paint()..color = Colors.black);
      }

      if (original.subcomponentes.isNotEmpty) {
        cloneComponentTree(original.subcomponentes, destination, cloned, null);
      }
    }
  }

  List<Rama> ramas = [];
  int idRama = 1;
  List<int> cantidades = [];
  List<int> rms = [];
  List<Componente> fetchComponentsOfProduct(int idProducto) {
    List<Componente> components = [];
    idRama = 1;
    ramas = [];
    var productUnions =
        unn.where((u) => u.idPadre == idProducto && u.PadreEsProducto).toList();
    uniondemanda.addAll(productUnions);
    for (var union in productUnions) {
      rms = [];
      cantidades = [];
      Componente component = findComponentById(union.idHijo);
      _nombres.add('${component.nombre} (${union.CantidadHijo})');
      components.add(component);
      rms.add(idRama);
      cantidades.add(union.CantidadHijo);
      ramas.add(
          Rama(idRamas: rms, nombre: component.nombre, cantidad: cantidades));
      addSubcomponentes(component);
      idRama += 1;
    }
    notifyListeners();
    return components;
  }

    bool existeString(String nombre, String original){

    int index = nombre.indexOf('(');
    String cadena1 = '';
    String cadena2 = nombre;
    if(index!=-1){
      cadena1 = cadena2.substring(0,index-1);
      if(compararCadenasSinEspacios(cadena1, original)){
        return true;
      }
      
    }else{
      return false;
    }

    return false;
  }

  bool compararCadenasSinEspacios(String cadena1, String cadena2) {
  String cadena1SinEspacios = cadena1.replaceAll(' ', '');
  String cadena2SinEspacios = cadena2.replaceAll(' ', '');
  return cadena1SinEspacios == cadena2SinEspacios;
}

  Componente findComponentById(int idComponente) {
    return comps.firstWhere((c) => c.idComponente == idComponente);
  }

  List<Union> uniondemanda = [];
  void addSubcomponentes(Componente componente) {
    var relevantUnions = unn
        .where(
            (u) => u.idPadre == componente.idComponente && !u.PadreEsProducto)
        .toList();
    uniondemanda.addAll(relevantUnions);
    for (var union in relevantUnions) {
      Componente subcomponente = findComponentById(union.idHijo);
      //  List<int> rms = [];
      if (!componente.subcomponentes
          .any((c) => c.idComponente == subcomponente.idComponente)) {
        if (_nombres
            .where((element) =>existeString(element, subcomponente.nombre))
            .isEmpty) {
          _nombres.add('${subcomponente.nombre} (${union.CantidadHijo})');
          // rms.add(idRama);
          cantidades.add(union.CantidadHijo);
          ramas.add(Rama(
              idRamas: rms,
              nombre: subcomponente.nombre,
              cantidad: cantidades));
          cantidades.removeLast();
        } else {
          for (int i = 0; i < _nombres.length; i++) {
            if (existeString(_nombres[i], subcomponente.nombre)) {
              _nombres[i] = '${nombres[i]} (${union.CantidadHijo})';
              rms.add(idRama);
              cantidades.add(union.CantidadHijo);
              ramas.add(Rama(
                  idRamas: rms,
                  nombre: subcomponente.nombre,
                  cantidad: cantidades));
            }
          }
        }
        notifyListeners();
        componente.subcomponentes.add(subcomponente);
        addSubcomponentes(subcomponente);
      }
    }
  }

  Future<void> deleteComponetns(int id) async {
    final response =
        await client.from('Componente').delete().match({'IdComponente': id});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> updateComponents(int id, String nombre, int cantidad) async {
    final response = await client.from('Componente').update(
        {'nombre': nombre, 'cantidad': cantidad}).match({'IdComponente': id});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> addComponent(String nombre, int cantidad) async {
    final response = await client
        .from('Componente')
        .insert({'nombre': nombre, 'cantidad': cantidad, 'IdUsuario': _idUsuario});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> setUnions() async {
    VU = [];
    for (var p in prd) {
      !VU.contains(
              ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true))
          ? VU.add(
              ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true))
          : null;
    }
    for (var c in comps) {
      !VU.contains(
              ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false))
          ? VU.add(
              ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false))
          : null;
    }
    notifyListeners();
  }

  bool tieneciclo(Componente padre, Componente hijo){
    if(padre.subcomponentes.isEmpty){
      return false;
    }
    for(var a in padre.subcomponentes){
      if(a.idComponente == hijo.idComponente){
         Exception('No se puede realizar la union!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
         return true;
      }
    }

    for(var a in padre.subcomponentes){
      
      tieneciclo(a, hijo);
    }
    return false;
  }

  Future<void> addUnions(
      String padre, String hijo, cantidad1, bool PadreEsProducto, Node? parent) async {

    if (prd.where((element) => element.nombre == padre).isNotEmpty) {
      
      final response = await client.from('Union').insert({
        'idHijo':
            comps.firstWhere((element) => element.nombre == hijo).idComponente,
        'idPadre':
            prd.firstWhere((element) => element.nombre == padre).idProducto,
        'CantidadHijo': cantidad1,
        'PadreEsProducto': true
        , 'IdUsuario': _idUsuario
      });
      if (response == null) {
        fetchProducts();
      } else {
        notifyListeners();
      }
    } else {
      tieneciclo(comps.firstWhere((element) => element.nombre == padre), comps.firstWhere((element) => element.nombre == hijo));
      final response = await client.from('Union').insert({
        'idHijo':
            comps.firstWhere((element) => element.nombre == hijo).idComponente,
        'idPadre':
            comps.firstWhere((element) => element.nombre == padre).idComponente,
        'CantidadHijo': cantidad1,
        'PadreEsProducto': false
        , 'IdUsuario': _idUsuario
      });
      if (response == null) {
        fetchProducts();
      } else {
        notifyListeners();
      }
    }
    await fetchProducts();
    _nombres = [];
      todo = fetchComponentsOfProduct(IdProducto);
      x = [];
      cloneComponentTree(todo, x, null, prd);
    
    
     
  }
  void addSubcomponentes1(Componente componente) {
    var relevantUnions = unn.where((u) => u.idPadre == componente.idComponente && !u.PadreEsProducto).toList();
    uniondemanda.addAll(relevantUnions);
    for (var union in relevantUnions) {
      Componente subcomponente = findComponentById(union.idHijo);
      //  List<int> rms = [];
      if (!componente.subcomponentes
          .any((c) => c.idComponente == subcomponente.idComponente)) {
        if (_nombres
            .where((element) =>existeString(element, subcomponente.nombre))
            .isEmpty) {
          _nombres.add('${subcomponente.nombre} (${union.CantidadHijo})');

        } else {
          for (int i = 0; i < _nombres.length; i++) {
            if (existeString(_nombres[i], subcomponente.nombre)) {
              _nombres[i] = '${nombres[i]} (${union.CantidadHijo})';
           
            }
          }
        }
        notifyListeners();
        componente.subcomponentes.add(subcomponente);
        addSubcomponentes1(subcomponente);
      }
    }
  }

  List<Demanda> dems = [];

  void ShowDemanda(int idProduct) {
    uniondemanda = [];
    setGraphProps(idProduct);
    dems = generarDemanda(uniondemanda, comps, idProduct);

    notifyListeners();
  }

  List<Demanda> generarDemanda(
      List<Union> unions, List<Componente> componentes, int productoId) {
    Map<int, String> calculos = {};
    Set<int> procesados = {}; // Conjunto para rastrear los nodos procesados
    Queue<MapEntry<int, String>> queue = Queue();

    queue.add(MapEntry(productoId, ''));

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      int currentId = current.key;
      String currentCalculo = current.value;

      if (procesados.contains(currentId)) {
        continue; // Si ya se ha procesado, salta al siguiente
      }

      procesados.add(currentId);

      for (var union in unions) {
        if (union.idPadre == currentId) {
          String nuevoCalculo = currentCalculo.isEmpty
              ? '(${union.CantidadHijo})'
              : '$currentCalculo(${union.CantidadHijo})';

          // Asegurarse de que la clave existe antes de concatenar
          if (calculos.containsKey(union.idHijo)) {
            calculos[union.idHijo] = calculos[union.idHijo]! + nuevoCalculo;
          } else {
            calculos[union.idHijo] = nuevoCalculo;
          }

          queue.add(MapEntry(union.idHijo, nuevoCalculo));
        }
      }
    }

    List<Demanda> demandas = [];

    for (var componente in componentes) {
      if (calculos.containsKey(componente.idComponente)) {
        int resultado = calcularResultado(
            calculos[componente.idComponente]!, demanda.round());
        demandas.add(Demanda(
            nombre: componente.nombre,
            calculo: '${calculos[componente.idComponente]!} ($demanda)',
            resultado: resultado));
      }
    }

    return demandas;
  }

  int calcularResultado(String calculo, int demandaUsuario) {
    RegExp exp = RegExp(r'\((\d+)\)');
    Iterable<Match> matches = exp.allMatches(calculo);
    int resultado = demandaUsuario;

    for (var match in matches) {
      resultado *= int.parse(match.group(1)!);
    }

    return resultado;
  }

  String nombrePadre = '';
  String get _NombrePadre => nombrePadre;
  List<ViewUnion> GetUniones() {
    VU = [];
    for (var p in prd) {
      !VU.contains(
              ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true))
          ? VU.add(
              ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true))
          : null;
    }
    for (var c in comps) {
      !VU.contains(
              ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false))
          ? VU.add(
              ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false))
          : null;
    }
    notifyListeners();
    return VU;
  }

  Future<void> deteleUnion(List<String> padres, String hijo) async {
    int idpadre = 0;
    int idhijo = 0;
    for (var a in padres) {
      if (prd.any((element) => element.nombre == a)) {
        idpadre = prd.firstWhere((element) => element.nombre == a).idProducto;
        idhijo =
            comps.firstWhere((element) => element.nombre == hijo).idComponente;
      } else {
        idpadre =
            comps.firstWhere((element) => element.nombre == a).idComponente;
        idhijo =
            comps.firstWhere((element) => element.nombre == hijo).idComponente;
      }
      final response = await client
          .from('Union')
          .delete()
          .match({'idPadre': idpadre, 'idHijo': idhijo});
      if (response == null) {
        fetchProducts();
      } else {
        notifyListeners();
      }
    }
   
    notifyListeners();
  }

  //final Graph graph = Graph();
  final Map<Node, List<Node>> parentNodeMap = {};

 
  void removeNode(Node node) {
    setGraphProps(_IdProducto);
    final parent = parentNodeMap[node];
    if (parent != null) {
      graph.removeNode(node);
      parentNodeMap.remove(node);
      parentNodeMap.removeWhere((key, value) => value == node);
      notifyListeners();
    }
  }

  String? getNodeName(Node node) {
    return node.key?.value?.toString();
  }

  List<String> getParentNodeNames(Node node) {
    final parents = parentNodeMap[node];
    if (parents != null) {
      return parents
          .map((parent) => parent.key?.value?.toString() ?? '')
          .toList();
    }
    return [];
  }
}
