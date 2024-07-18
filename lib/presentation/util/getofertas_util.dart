import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/kanbanes_provider.dart';
import 'package:provider/provider.dart';

class GetOfertas {
  static void show(BuildContext context) {
    final KanbanesProvider watch = Provider.of<KanbanesProvider>(context, listen: false);

    if (watch.periodos == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          final KanbanesProvider watch = Provider.of<KanbanesProvider>(context, listen: false);

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              expand: false,
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Agregar ofertas',
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: watch.periodos,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: TextField(
                                keyboardType: TextInputType.number,
                                controller: watch.controllersO[index],
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
                        SizedBox(height: 20),
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
                            TextButton(
                              onPressed: () {
                                Provider.of<KanbanesProvider>(context, listen: false).getValuesO();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
