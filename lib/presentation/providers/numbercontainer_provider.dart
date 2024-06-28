// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class NumberContainerProvider extends ChangeNotifier {
  int _demanda = 0;
  double _tiempo = 0;
  int _tamano = 0;


  int get demanda => _demanda;
  double get tiempo => _tiempo;
  int get tamano => _tamano;


  Future<void> setNumberContainer({
    demanda,
    tiempo,
    tamano,

  }) async {
    _demanda = demanda ?? _demanda;
    _tiempo = tiempo ?? _tiempo;
    _tamano = tamano ?? _tamano;
    
    notifyListeners();
  }
}
