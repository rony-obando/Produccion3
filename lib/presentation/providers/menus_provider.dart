
import 'package:flutter/material.dart';

class MenusProvider extends ChangeNotifier{
  bool _showTextBoxes = false;
  bool _showMrpMenu = false;
  bool _showLTC = false;

  bool get showTextBoxes => _showTextBoxes;
  bool get showMrpMenu => _showMrpMenu;
  bool get showLTC => _showLTC;

  Future<void> setMenusProps({
    showTextBoxes,
    showMrpMenu,
    showLTC,
    }) async{
      _showTextBoxes = showTextBoxes?? _showTextBoxes;
      _showMrpMenu = showMrpMenu?? _showMrpMenu;
      _showLTC = showLTC?? _showLTC;

      notifyListeners();
  }

  int _numberOfPeriods = 4;
  List<int> _quantities = [];

  int get numberOfPeriods => _numberOfPeriods;
  List<int> get quantities => _quantities;

  void setNumberOfPeriods(int count) {
    _numberOfPeriods = count;
    _quantities = List.filled(count, 0);
    notifyListeners();
  }

  void setQuantity(int index, int quantity) {
    if (index < _quantities.length) {
      _quantities[index] = quantity;
    }
    notifyListeners();
  }

    bool _isOpen = false;

  bool get isOpen => _isOpen;

  void openDrawer() {
    _isOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    _isOpen = false;
    notifyListeners();
  }

  void toggleDrawer() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

}