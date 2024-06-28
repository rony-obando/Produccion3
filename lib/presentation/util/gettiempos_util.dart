import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/kanbanes_provider.dart';
import 'package:provider/provider.dart';

class GetTiempos {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          KanbanesProvider watch = context.watch<KanbanesProvider>();
          if (watch.periodos == 0) {
            return AlertDialog(
              // backgroundColor: const Color.fromARGB(255, 215, 172, 169),
              title: const Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  Text(
                    'Error',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: const Text(
                'Agregue cantidad de períodos',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cerrar',
                  ),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'Agregar tiempos de entrega',
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
                            controller: watch.controllersT[index],
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Unidades en el período: ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
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
                        context.read<KanbanesProvider>().getValuesT();
                        // ignore: use_build_context_synchronously

                        Navigator.of(context).pop();
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }
}
