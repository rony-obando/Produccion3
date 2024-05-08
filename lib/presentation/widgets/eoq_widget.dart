// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/providers/Eoq_Provider.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';
import 'package:provider/provider.dart';

const route = '/notification-save';

// ignore: camel_case_types
class eoq_widget extends StatelessWidget {
  const eoq_widget({super.key});

  @override
  Widget build(BuildContext context) {

    Eoq_Provider watch = context.watch<Eoq_Provider>();
    String dropdownValue = '/Dia';
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
                    context.read<Eoq_Provider>().setEoqProps(demanda: double.tryParse(text));
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
            Flexible(
              child: DropdownButton<String>(
                value: watch.newValue,
                onChanged: (newValue) {
                  context.read<Eoq_Provider>().setEoqProps(newValue: newValue);
                  
                },
                items: <String>['/Dia', '/Semana', '/Mes', '/Año']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              context.read<Eoq_Provider>().setEoqProps(costopedidos: double.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costo de hacer el pedido',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              context.read<Eoq_Provider>().setEoqProps(costomantenimiento: double.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costo de mantenimiento anual por unidad',
              labelStyle: TextStyle(fontSize: 13),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              try {
                  resultado = Calcular_EOQ(
                      watch.demanda, watch.costopedidos, watch.costomantenimiento, watch.periodo);
                show_result_widget.show(
                    context,
                    'EOQ',
                    'La cantidad de pedidos que la empresa deberá realizar es de $resultado unidades para que el inventario no se agote durante el tiempo dentrega',
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

