import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:provider/provider.dart';

class GetPeridosUtil {
  static void show(
      BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          MenusProvider watch = context.watch<MenusProvider>();

          return AlertDialog(
            title: const Center(
            child: Text(
              'Agregar Unidades',
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
            content: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: watch.numberOfPeriods,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextField(
                          decoration:
                              InputDecoration(labelText: 'Unidades en el período: ${index + 1}'),
                        ),
                        /* trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () => _removeTextField(index),
            ),*/
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar',style: TextStyle(color: Colors.red),),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                   
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
          );
        });
  }
}
