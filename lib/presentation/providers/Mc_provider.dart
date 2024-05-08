import 'package:flutter/material.dart';


// ignore: camel_case_types
class Mc_provider extends ChangeNotifier {
  double _numerofallas = 0;
  double _duraciontarea = 0;
  double _costohoratrabajo = 0;
  double _respuestos = 0;
  double _costooperacionales = 0;
  double _retrasologistico = 0;
  double _costoparada = 0;
  double _costofallaunica = 0;
  double _resultado = 0;
  bool _showAdditionalFields = false;
  int _horasmantenimiento = 0;
  double _mtbf = 0;

  double get numerofallas => _numerofallas;
  double get duraciontarea => _duraciontarea;
  double get costohoratrabajo => _costohoratrabajo;
  double get respuestos => _respuestos;
  double get costooperacionales => _costooperacionales;
  double get retrasologistico => _retrasologistico;
  double get costoparada => _costoparada;
  double get costofallaunica => _costofallaunica;
  double get resultado => _resultado;
  bool get showAdditionalFields => _showAdditionalFields;
  int get horasmantenimiento => _horasmantenimiento;
  double get mtbf => _mtbf;

  Future<void> setCMprops({numerofallas, 
  duraciontarea, 
  costohoratrabajo, 
  respuestos, 
  costooperacionales,
  retrasologistico,
  costoparada,
  costofallaunica,
  resultado,
  showAdditionalFields,
  horasmantenimiento,
  mtbf,}) async {
    _numerofallas = numerofallas ?? _numerofallas;
    _duraciontarea = duraciontarea ?? _duraciontarea;
    _costohoratrabajo = costohoratrabajo??_costohoratrabajo;
    _respuestos = respuestos ?? _respuestos;
    _costooperacionales = costooperacionales ?? _costooperacionales;
    _retrasologistico = retrasologistico ?? _retrasologistico;
    _costoparada = costoparada??_costoparada;
    _costofallaunica = costofallaunica??_costofallaunica;
    _resultado = resultado??_resultado;
    _showAdditionalFields = showAdditionalFields??_showAdditionalFields;
    _horasmantenimiento = horasmantenimiento??_horasmantenimiento;
    _mtbf = mtbf??_mtbf;
    notifyListeners();
  }
}