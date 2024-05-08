import 'package:flutter/material.dart';

class Inventoryprovider extends ChangeNotifier{
  
  int _demanda = 0; 
  int _ss = 0;
  int _ciclo = 0;
  bool _fijo = false;
  int _cantidadpedida = 0;

  int get demanda => _demanda;
  int get ss => _ss;
  int get ciclo => _ciclo;
  bool get fijo => _fijo;
  int get cantidadpedida => _cantidadpedida;

  Future<void> setRotation({
    demanda,
    ss,
    ciclo,
    fijo,
    cantidadpedida,
    }) async{
      _demanda = demanda??_demanda;
      _ss = ss??_ss;
      _ciclo = ciclo??_ciclo;
      _fijo = fijo??_fijo;
      _cantidadpedida = cantidadpedida??_cantidadpedida;
      notifyListeners();
  }

}