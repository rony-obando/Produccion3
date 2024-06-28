import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/ltc_luc_provider.dart';
import 'package:provider/provider.dart';

class GetPeridosUtil {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          LtcLucProvider watch = context.watch<LtcLucProvider>();
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
                    itemCount: watch.periodos,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextField(
              keyboardType: TextInputType.number,
              controller: watch.controllers[index],
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration:  InputDecoration(
                labelText: 'Unidades en el período: ${index + 1}',
                border: const OutlineInputBorder(),
              ),
            ),
                        /*title: TextField(
                          controller: watch.controllers[index],
                          decoration: InputDecoration(
                              labelText:
                                  'Unidades en el período: ${index + 1}'),
                        ),*/
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
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      
                      context.read<LtcLucProvider>().getValues();
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
