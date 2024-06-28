import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LtcLucProvider extends ChangeNotifier{
  int _peridos = 0;
  double _costoorden = 0;
  double _costomanten = 0;
  bool isLoading = true;
  List<int> _unidades = [];
  List<TextEditingController> controllers = [];
  TextEditingController controllercostoorden = TextEditingController();
  TextEditingController controllercostomanteni = TextEditingController();
  TextEditingController controllerperiodos = TextEditingController();
  dynamic _widg;


  int get periodos => _peridos;
  double get costoorden => _costoorden;
  double get costomanten => _costomanten;
  List<int> get unidades => _unidades;
  dynamic get widg => _widg;
  
  void changeLoading(){
    isLoading = false;
    notifyListeners();
  }
 
  Future<void> setLTCLUCProps({
    periodos,
    costoorden,
    costomanten,
    widg
  }) async{
    _peridos = periodos?? _peridos;
    _costoorden = costoorden?? _costoorden;
    _widg = widg?? _widg;
    _costomanten = costomanten?? _costomanten;
    notifyListeners();
  }

    void updateControllers() {
    if (_peridos < controllers.length) {
      // Eliminar controladores extra si se reduce el número de campos
      controllers = controllers.sublist(0, _peridos);
    } else {
      // Agregar controladores necesarios si aumenta el número de campos
      while (controllers.length < _peridos) {
        controllers.add(TextEditingController());
      }
    }
    notifyListeners();
  }
  
  void getValues() {
    _unidades = [];
    for(var a in controllers.map((controller) => controller.text).toList()){
      _unidades.add(int.tryParse(a)!);
    }
    notifyListeners();
  }

  final TextEditingController controllermante = TextEditingController();

  TextEditingController get getController => controllermante;

  void updateText(String newText) {
    controllermante.text = newText;
    notifyListeners();
  }

  final TextEditingController controllerorden = TextEditingController();

  TextEditingController get getControllerorden => controllerorden;

  void updateTextorden(String newText) {
    controllerorden.text = newText;
    notifyListeners();
  }

  final TextEditingController controllerperido = TextEditingController();

  TextEditingController get getcontrollerperido => controllerperido;

  void updateperiodo(String newText) {
    controllerperido.text = newText;
    notifyListeners();
  }


}