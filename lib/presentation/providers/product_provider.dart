import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/Componente.dart';
import 'package:frontendapp/config/domain/entities/Producto.dart';
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
  List<String> nombres = [];
  List<Componente> todo = [];
  List<Componente> comps = [];
  List<Union> unn = [];
  List<Producto> prd = [];
  // ignore: non_constant_identifier_names
  List<ViewUnion> VU = [];
  String _selectedUV = '';
  String _selectedUV1 = '';
  Graph _graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration _builder = BuchheimWalkerConfiguration();
  bool isLoading = true;
  // ignore: non_constant_identifier_names
  int _IdProducto = 0;

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

  Graph get graph => _graph;
  BuchheimWalkerConfiguration get builder => _builder;
  // ignore: non_constant_identifier_names
  int get IdProducto => _IdProducto;
  int get cantidad => _cantidad;
  String get nombre => _name;
  String get selectedUV => _selectedUV;
  String get selectedUV1 => _selectedUV1;

  // ignore: non_constant_identifier_names
  Future<void> setGraphProps(IdProducto) async {
    if (IdProducto != null) {
      _graph = Graph()..isTree = true;
      resetTransformation();
      _IdProducto = IdProducto;
      todo = fetchComponentsOfProduct(IdProducto);
      x = [];
      cloneComponentTree(todo, x, null, prd);
      _builder
        ..siblingSeparation = (50)
        ..levelSeparation = (100)
        // ..subtreeSeparation = (100)
        ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

      notifyListeners();
    }
  }

  Future<void> setProductprops({nombre, cantidad}) async {
    _name = nombre ?? _name;
    _cantidad = cantidad ?? _cantidad;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      final response =
          await client.from('Producto').select('nombre, cantidad, id');
      final responseunion = await client.from('Union').select();
      final responsecomponente = await client.from('Componente').select();

      products = List<Map<String, dynamic>>.from(response);
      unions = List<Map<String, dynamic>>.from(responseunion);
      componentes = List<Map<String, dynamic>>.from(responsecomponente);

      final data = responsecomponente as List;
      comps = data.map((json) => Componente.fromJson(json)).toList();
      final data1 = responseunion as List;
      unn = data1.map((json) => Union.fromJson(json)).toList();
      final data2 = response as List;
      prd = data2.map((json) => Producto.fromJson(json)).toList();
      _selectedUV = prd.first.nombre;
      _selectedUV1 = comps.first.nombre;
      for (var c in comps) {
        nombres.add(c.nombre);
      }
      setUnions();
    // ignore: empty_catches
    } catch (e) {

    }
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
        .insert({'nombre': nombre, 'cantidad': cantidad});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  void cloneComponentTree(List<Componente> source, List<Componente> destination,
      Componente? anterior, List<Producto>? producto) {
    for (Componente original in source) {
      Componente cloned = original.cloneWithoutSubcomponents();
      destination.add(cloned);

      if (producto != null) {
        Node node1 = Node.Id(producto
            .firstWhere((element) => element.idProducto == _IdProducto)
            .nombre);
        Node node2 = Node.Id(original.nombre);
        graph.addEdge(node1, node2, paint: Paint()..color = Colors.black);
      } else {
        Node node1 = Node.Id(anterior?.nombre);
        Node node2 = Node.Id(original.nombre);

        graph.addEdge(node1, node2, paint: Paint()..color = Colors.black);
      }

      if (original.subcomponentes.isNotEmpty) {
        cloneComponentTree(original.subcomponentes, destination, cloned, null);
      }
    }
  }

  List<Componente> fetchComponentsOfProduct(int idProducto) {
    List<Componente> components = [];

    var productUnions =
        unn.where((u) => u.idPadre == idProducto && u.PadreEsProducto).toList();
    for (var union in productUnions) {
      Componente component = findComponentById(union.idHijo);
      components.add(component);
      addSubcomponentes(component);
    }

    return components;
  }

  Componente findComponentById(int idComponente) {
    return comps.firstWhere((c) => c.idComponente == idComponente);
  }

  void addSubcomponentes(Componente componente) {
    var relevantUnions = unn
        .where(
            (u) => u.idPadre == componente.idComponente && !u.PadreEsProducto)
        .toList();
    for (var union in relevantUnions) {
      Componente subcomponente = findComponentById(union.idHijo);
      if (!componente.subcomponentes
          .any((c) => c.idComponente == subcomponente.idComponente)) {
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
        .insert({'nombre': nombre, 'cantidad': cantidad});
    if (response == null) {
      fetchProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> setUnions() async {
    for (var p in prd) {
      !VU.contains(
              ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true)) ?
          VU.add(ViewUnion(id: p.idProducto, name: p.nombre, EsProducto: true)):null;
    }
    for (var c in comps) {
           !VU.contains(
              ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false)) ?
          VU.add(ViewUnion(id: c.idComponente, name: c.nombre, EsProducto: false)):null;
    }
    notifyListeners();
  }

  Future<void> addUnions(String padre, String hijo, cantidad1) async {
    if (prd.where((element) => element.nombre == padre).isNotEmpty) {
      final response = await client.from('Union').insert({
        'idHijo':
            comps.firstWhere((element) => element.nombre == hijo).idComponente,
        'idPadre':
            prd.firstWhere((element) => element.nombre == padre).idProducto,
        'CantidadHijo': cantidad1,
        'PadreEsProducto': true
      });
      if (response == null) {
        fetchProducts();
      } else {
        notifyListeners();
      }
    } else {
      final response = await client.from('Union').insert({
        'idHijo':
            comps.firstWhere((element) => element.nombre == hijo).idComponente,
        'idPadre':
            prd.firstWhere((element) => element.nombre == padre).idProducto,
        'CantidadHijo': cantidad1,
        'PadreEsProducto': false
      });
      if (response == null) {
        fetchProducts();
      } else {
        notifyListeners();
      }
    }
  }
}
