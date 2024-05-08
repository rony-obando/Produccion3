// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/widgets/show_actions.dart';
import 'package:provider/provider.dart';

class AddComponent extends StatelessWidget {
  const AddComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider watch = context.watch<ProductProvider>();
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextField(
            onChanged: (text) {
              context
                  .read<ProductProvider>()
                  .setProductprops(nombre: text.toString());
            },
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              context
                  .read<ProductProvider>()
                  .setProductprops(cantidad: int.tryParse(text));
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              labelText: 'cantidad',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              ShowActionsWidget.show(
                  context, watch.nombre, watch.cantidad, 'Componente');
            },
            child: const Text('Agregar Componente'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
