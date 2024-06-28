import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class AddUnionUtil {
  static void show(BuildContext context, String text, Node node) {
    context.read<ProductProvider>().setProductprops(cantidad: 0);
    context.read<ProductProvider>().setProductprops(text1: '');
    List<String> items1 = context
        .read<ProductProvider>()
        .GetUniones()
        .where((element) => !element.EsProducto)
        .map((element) => element.name)
        .toList();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          ProductProvider watch = context.watch<ProductProvider>();
          //LtcLucProvider watch = context.watch<LtcLucProvider>();
          return AlertDialog(
            title: Center(
              child: Text(
                'Agregar un componente a $text',
                style: const TextStyle(color: Colors.black87, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: watch.selectedUV1.isEmpty
                      ? items1.first
                      : watch.selectedUV1,
                  onChanged: (text1) {
                    watch.setSelectedItem(item1: text1.toString());
                    watch.setSelectedItem(item: text.toString());
                  },
                  items: items1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  icon: Container(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    context
                        .read<ProductProvider>()
                        .setProductprops(cantidad: text.isEmpty?0:int.tryParse(text));
                        if(int.tryParse(text.isEmpty?'0':text)!>0){
                          context.read<ProductProvider>().setProductprops(text1: '');
                        }
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Cantidad del componente',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(watch.text1),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (watch.cantidad == 0) {
                      context.read<ProductProvider>().setProductprops(text1: 'Ingresa una cantidad de componentes mayor a 0');
                    } else {
                      context.read<ProductProvider>().setProductprops(text1: '');
                      context.read<ProductProvider>().addUnions(
                          watch.selectedUV,
                          watch.selectedUV1,
                          watch.cantidad,
                          false,
                          node);
                      watch.setSelectedItem(item: text.toString());

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Agregar Unión'),
                ),
              ],
            ),
            )
          );
        });
  }
}
