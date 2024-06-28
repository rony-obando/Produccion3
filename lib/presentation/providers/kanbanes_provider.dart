import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class KanbanesProvider extends ChangeNotifier{

  int _periodos = 0;
  double _seguridad = 0;
  List<int> demandas = [];
  List<int> ofertas = [];
  List<double> tiempoentrega = [];
  List<int> capacidad = [];
  List<TextEditingController> controllersD = [];
  List<TextEditingController> controllersO = [];
  List<TextEditingController> controllersT = [];
  List<TextEditingController> controllersC = [];

  int get periodos => _periodos;
  double get seguridad => _seguridad;

  void getValuesD() {
    demandas = [];
    for(var a in controllersD.map((controller) => controller.text).toList()){
      demandas.add(int.tryParse(a.isEmpty? '0': a)!);
    }
    
    notifyListeners();
  }

  void getValuesO(){
     ofertas = [];
     for(var a in controllersO.map((controller) => controller.text).toList()){
      ofertas.add(int.tryParse(a.isEmpty? '0': a)!);
    }
  }

  void getValuesT(){
    tiempoentrega = [];
    for(var a in controllersT.map((controller) => controller.text).toList()){
      tiempoentrega.add(double.tryParse(a.isEmpty? '0': a)!);
    }
  }

  void getValuesC(){
    capacidad = [];
    for(var a in controllersC.map((controller) => controller.text).toList()){
      capacidad.add(int.tryParse(a.isEmpty? '0': a)!);
    }
  }

  Future<void> setPeriodos({periodos, seguridad}) async{
    _periodos = periodos?? _periodos;
    _seguridad = seguridad?? _seguridad;
    notifyListeners();
  }

   void updateControllers() {
    if (_periodos < controllersD.length) {
      // Eliminar controladores extra si se reduce el número de campos
      controllersD = controllersD.sublist(0, _periodos);
      controllersT = controllersD.sublist(0, _periodos);
      controllersO = controllersD.sublist(0, _periodos);
      controllersC = controllersD.sublist(0, _periodos);
    } else {
      // Agregar controladores necesarios si aumenta el número de campos
      while (controllersD.length < _periodos) {
        controllersD.add(TextEditingController());
        controllersC.add(TextEditingController());
        controllersT.add(TextEditingController());
        controllersO.add(TextEditingController());
      }
    }
     notifyListeners();
    }




}