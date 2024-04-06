import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/local_notification_provider.dart';

// ignore: camel_case_types
class show_result_widget {
  static void show(BuildContext context,String method, String dialog, double result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado del cálculo',
          style: TextStyle(
            color: Colors.black87
          ),
          ),
           titlePadding: const EdgeInsets.all(20),
          content: Text('$dialog\n' '\n¿Desea guardar el resultado?', 
          style: const TextStyle(
            fontSize: 15,
            ), textAlign: TextAlign.center,
          ),
      
          actions: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    printNotifications(method,result);
                  },
                  child: const Text('Guardar'),
                  
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}