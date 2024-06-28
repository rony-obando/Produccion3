
import 'package:flutter/material.dart';

class PlaneacioProvider extends ChangeNotifier{

  int _meses = 6;
  List<int> _nmDefectuosos = List.filled(12, 0);
  List<double> _fraccion = List.filled(12, 0);
  List<String> get monthNames => [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  int get meses => _meses;
  List<int> get nmDefectuosos => _nmDefectuosos;
  List<double> get fraccion => _fraccion;

  Future<void> setPlanProps({meses, nmDefectuosos, fraccion}) async{
    _meses = meses?? _meses;
    _nmDefectuosos = nmDefectuosos?? _nmDefectuosos;
    _fraccion = fraccion?? _fraccion;
    notifyListeners();
  }

}