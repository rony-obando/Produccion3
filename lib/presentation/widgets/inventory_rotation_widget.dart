// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/providers/inventory_rotation.provider.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';
import 'package:provider/provider.dart';

const route = '/notification-save';

// ignore: camel_case_types, must_be_immutable
class rotation_widget extends StatelessWidget {
  rotation_widget({super.key});

  int resultado = 0;

  @override
  // ignore: library_private_types_in_public_api
  Widget build(BuildContext context) {
    Inventoryprovider watch = context.watch<Inventoryprovider>();

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
              const Text(
                'Inventario fijo',
                style: TextStyle(fontSize: 17),
              ),
              Checkbox(
                value: watch.fijo,
                onChanged: (value) {
                  context.read<Inventoryprovider>().setRotation(fijo: value);
                },
              ),
            ],
          ),
          if (!watch.fijo)
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) {
                context
                    .read<Inventoryprovider>()
                    .setRotation(ciclo: int.tryParse(text));
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
            keyboardType: TextInputType.number,
            onChanged: (text) {
              context
                  .read<Inventoryprovider>()
                  .setRotation(demanda: int.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              labelText: 'Demanda',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              context
                  .read<Inventoryprovider>()
                  .setRotation(ss: int.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
              resultado = inventory_rotation(watch.demanda, watch.ss,
                  watch.ciclo, watch.cantidadpedida, watch.fijo);
              show_result_widget.show(context, 'Inventory_rotation',
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

class AdditionalFields extends StatelessWidget {
  const AdditionalFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (text) {
            context
                .read<Inventoryprovider>()
                .setRotation(cantidadpedida: int.tryParse(text));
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
