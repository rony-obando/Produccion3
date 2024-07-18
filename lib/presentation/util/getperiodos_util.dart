import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/ltc_luc_provider.dart';
import 'package:provider/provider.dart';

class GetPeridosUtil {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        LtcLucProvider watch = context.watch<LtcLucProvider>();
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
                        'Agregar Unidades',
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
                              controller: watch.controllers[index],
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                              context.read<LtcLucProvider>().getValues();
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
