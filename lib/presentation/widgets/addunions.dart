import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/config/domain/entities/viewunion.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/widgets/show_actions.dart';
import 'package:provider/provider.dart';

class AddProductos extends StatelessWidget {
  const AddProductos({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider watch = context.watch<ProductProvider>();

    List<String> items = watch.VU.map((element) => element.name).toList();
    List<String> items1 = watch.VU
        .where((element) => !element.EsProducto)
        .map((element) => element.name)
        .toList();
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Seleccionar padre',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: DropdownButton<String>(
              isExpanded: true,
              value: watch.selectedUV.isEmpty ? items.first : watch.selectedUV,
              onChanged: (text) {
                watch.setSelectedItem(item: text.toString());
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
              icon: Container(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Seleccionar hijo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: DropdownButton<String>(
              isExpanded: true,
              value:
                  watch.selectedUV1.isEmpty ? items1.first : watch.selectedUV1,
              onChanged: (text) {
                watch.setSelectedItem(item1: text.toString());
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
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              context.read<ProductProvider>().setProductprops(
                  cantidad: int.tryParse(text.isEmpty ? '0' : text));
              if (int.tryParse(text.isEmpty ? '0' : text)! > 0) {
                context.read<ProductProvider>().setProductprops(text1: '');
              }
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              labelText: 'cantidad de hijos',
              border: OutlineInputBorder(),
            ),
          ),
          Text(watch.text1),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              if (watch.cantidad == 0) {
                context.read<ProductProvider>().setProductprops(
                    text1: 'Ingresa una cantidad de hijos mayor a 0');
              } else {
                context.read<ProductProvider>().setProductprops(text1: '');
                context.read<ProductProvider>().addUnions(watch.selectedUV,
                    watch.selectedUV1, watch.cantidad, true, null);
              }
            },
            child: const Text('Agregar Unión'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
