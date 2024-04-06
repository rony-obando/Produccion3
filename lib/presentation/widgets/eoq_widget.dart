// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';

const route = '/notification-save';

// ignore: camel_case_types
class eoq_widget extends StatefulWidget {
  const eoq_widget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  Eoq createState() => Eoq();
}

class Eoq extends State<eoq_widget> {
  double demanda = 0;
  double costopedidos = 0;
  double costomantenimiento = 0;
  int resultado = 0;
  String dropdownValue = '/Dia';
  int periodo = 365;

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      try {
                        demanda = double.tryParse(text)!;
                        // ignore: empty_catches
                      } catch (e) {}
                    });
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
                value: dropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    if (newValue == '/Dia') {
                      periodo = 365;
                    } else if (newValue == '/Semana') {
                      periodo = 52;
                    } else if (newValue == '/Mes') {
                      periodo = 12;
                    } else {
                      periodo = 1;
                    }
                  });
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
              setState(() {
                try {
                  costopedidos = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
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
              setState(() {
                try {
                  costomantenimiento = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
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
                setState(() {
                  resultado = Calcular_EOQ(
                      demanda, costopedidos, costomantenimiento, periodo);
                });
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
