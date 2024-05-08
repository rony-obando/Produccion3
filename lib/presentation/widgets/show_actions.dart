import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ShowActionsWidget {
  static void show(
      BuildContext context, String nombre, int cantidad, String tipo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ProductProvider watch = context.watch<ProductProvider>();
        
        return AlertDialog(
          title: Center(
            child: Text(
              'Agregar $tipo',
              style: const TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ),
          titlePadding: const EdgeInsets.all(20),
          content: Text(
            '¿Quieres agregar $cantidad ${nombre.toUpperCase().endsWith('S') ? nombre : '${nombre.toLowerCase()}s?'}',
            style: const TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cerrar'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    if(tipo == 'Producto'){
                      context
                        .read<ProductProvider>()
                        .addProduct(watch.nombre, watch.cantidad);
                    }else if(tipo == 'Componente'){
                      context
                        .read<ProductProvider>()
                        .addComponent(watch.nombre, watch.cantidad);
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
