// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';

const route = '/notification-save';

class rotation_widget extends StatefulWidget {
  const rotation_widget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  rotation createState() => rotation();
}

class rotation extends State<rotation_widget> {
  int demanda = 0; 
  int ss = 0;
  int ciclo = 0;
  bool fijo = false;
  int resultado = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Inventario fijo',style: TextStyle(fontSize: 17),),
              Checkbox(
                value: fijo,
                onChanged: (value) {
                  setState(() {
                    fijo = value!;
                  });
                },
              ),
            ],
          ),
          if (!fijo)
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  try {
                    ciclo = int.tryParse(text)!;
                    // ignore: empty_catches
                  } catch (e) {}
                });
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Ciclo de revisión',
                border: OutlineInputBorder(),
              ),
            )
          else
            const AdditionalFields(),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  demanda = int.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Demanda',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  ss = int.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Inventario de seguridad',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
         
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                resultado = inventory_rotation(demanda, ss, ciclo, cantidadpedida, fijo);
              });
              show_result_widget.show(context, 'Rotación de inventario',
                  'El resultado es: $resultado', resultado.toDouble());
            },
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

 int cantidadpedida = 0;

class AdditionalFields extends StatefulWidget {
  const AdditionalFields({super.key});

  @override
  State<AdditionalFields> createState() => _AdditionalFieldsState();
}

class _AdditionalFieldsState extends State<AdditionalFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (text) {
            setState(() {
              try {
                cantidadpedida = int.tryParse(text)!;
                // ignore: empty_catches
              } catch (e) {}
            });
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: const InputDecoration(
            labelText: 'Cantidad pedida',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
