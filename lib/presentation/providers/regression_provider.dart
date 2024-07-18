import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RegressionProvider extends ChangeNotifier {
  List<TextEditingController> xControllers = [];
  List<TextEditingController> yControllers = [];
  TextEditingController countController = TextEditingController();
  double b1 = 0;
  double b0 = 0;
  List<double> xValues = [];
  List<double> yValues = [];
  bool error = false;
  List<FlSpot> scatterData(BuildContext context) {
    final List<FlSpot> scatterData = [];
     if (xValues.length == yValues.length && xValues.length > 1){
      error = false;
       xValues = [];
       yValues = [];
      for (var controller in xControllers) {
      double? value = double.tryParse(controller.text);
      if (value != null) {
        xValues.add(value);
      }
 
    }

    for (var controller in yControllers) {
      double? value = double.tryParse(controller.text);
      if (value != null) {
        yValues.add(value);
      }

    }
    
    if (xValues.reduce((current, next) => current < next ? current : next) !=
        0) {
      scatterData.add(FlSpot(0, b0));
    }
    for (int i = 0; i < xValues.length; i++) {
      scatterData.add(FlSpot(xValues[i], yValues[i]));
    }

    return scatterData;
     }else{
      error = true;
      
      
     }
     return scatterData;
     
  }

  void generateFields(int count) {
    xControllers = List.generate(count, (index) => TextEditingController());
    yControllers = List.generate(count, (index) => TextEditingController());
    notifyListeners();
  }

  void calculateLinearRegression(BuildContext context) {
     xValues = [];
     yValues = [];
     error = false;
    if(xValues.isEmpty){
      for (var controller in xControllers) {
      double? value = double.tryParse(controller.text);
      if (value != null) {
        xValues.add(value);
      }
      notifyListeners();
    }
    }
    
    if(yValues.isEmpty){
      for (var controller in yControllers) {
      double? value = double.tryParse(controller.text);
      if (value != null) {
        yValues.add(value);
      }
      notifyListeners();
    }
    }
    

    if (xValues.length == yValues.length && xValues.length > 1) {
      // double n = xValues.length.toDouble();
      int yp =
          (yValues.reduce((value, element) => value + element) / yValues.length)
              .round();
      int xp =
          (xValues.reduce((value, element) => value + element) / xValues.length)
              .round();

      double dm = 0;
      double nm = 0;
      for (int i = 0; i < xValues.length; i++) {
        dm = ((xValues[i] - xp) * (yValues[i] - yp)) + dm;
        nm = pow((xValues[i] - xp), 2) + nm;
      }
       b1 = ((dm / nm) * 10000).round() / 10000;
       b0 = yp - xp * b1;
      notifyListeners();
      /*showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Linear Regression Result'),
          content: Text('Slope: $b1\nIntercept: $b0'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );*/
    } else {
      error = true;
      showDialog(
        
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Por favor ingresar valores válidos para "X" y "Y".'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
