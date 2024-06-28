// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/providers/numbercontainer_provider.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';
import 'package:provider/provider.dart';

const route = '/notification-save';

// ignore: camel_case_types
class NumberContainer extends StatelessWidget {
  const NumberContainer({super.key});

  @override
  Widget build(BuildContext context) {
    NumberContainerProvider watch = context.watch<NumberContainerProvider>();
    int resultado = 0;

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                  minWidth: 100,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    context
                        .read<NumberContainerProvider>()
                        .setNumberContainer(demanda: int.tryParse(text));
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Demanda',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              context
                  .read<NumberContainerProvider>()
                  .setNumberContainer(tiempo: double.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Tiempo de vuelta de recipiente',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              context
                  .read<NumberContainerProvider>()
                  .setNumberContainer(tamano: int.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              labelText: 'Tamaño del recipiente',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              try {
                resultado = cantidad_recipientes(
                    watch.demanda, watch.tamano, watch.tiempo);
                    
                show_result_widget.show(
                    context,
                    'CantidadRecipientes',
                    'La cantidad de recipietes necesarios son: $resultado',
                    resultado.toDouble());
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Text('Error'),
                      content: Text('$e!!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
