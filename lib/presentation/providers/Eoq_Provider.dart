// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Eoq_Provider extends ChangeNotifier {
  double _demanda = 0;
  double _costopedidos = 0;
  double _costomantenimiento = 0;
  int _periodo = 365;
  String _newValue = '/Dia';

  double get demanda => _demanda;
  double get costopedidos => _costopedidos;
  double get costomantenimiento => _costomantenimiento;
  int get periodo => _periodo;
  String get newValue => _newValue;

  Future<void> setEoqProps({
    demanda,
    costopedidos,
    costomantenimiento,
    newValue,
  }) async {
    _demanda = demanda ?? _demanda;
    _costopedidos = costopedidos ?? _costopedidos;
    _costomantenimiento = costomantenimiento ?? _costomantenimiento;
    _newValue = newValue ?? _newValue;

    if (_newValue == '/Dia') {
      _periodo = 365;
    } else if (_newValue == '/Semana') {
      _periodo = 52;
    } else if (_newValue == '/Mes') {
      _periodo = 12;
    } else if (_newValue == '/Año')  {
      _periodo = 1;
    }
    notifyListeners();
  }
}
