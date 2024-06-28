// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class LoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _idUsuario = '';
  String _buttontext = 'Crear cuenta';
  String _text = '¿No tienes cuenta?';
 

  String get email => _email;
  String get password => _password;
  String get idUsuario => _idUsuario;
  String get buttontext => _buttontext;
  String get text => _text;


  Future<void> setLoginprops({
    email,
    password,
    id,
    buttontext,
    text
  }) async {
    _idUsuario = id?? _idUsuario;
    _email = email??_email;
    _password = password??_password;
    _buttontext = buttontext??_buttontext;
    _text = text??_text;
    notifyListeners();
  }
}
