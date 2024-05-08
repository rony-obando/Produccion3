import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/services/mermaidchart_services.dart';
import 'package:provider/provider.dart';
import 'package:frontendapp/presentation/util/navigation_util.dart';

// ignore: must_be_immutable

class ComponenteTable extends StatelessWidget {
  const ComponenteTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            const SizedBox(height: 20),
            const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Seleccione un Componente para actualizarlo o borrarlo",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
            DataTable(
          showCheckboxColumn: false,
          columns: const [
            
            DataColumn(label: Text('ID', style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
            DataColumn(label: Expanded(child: Text('Nombre', style: TextStyle(fontSize: 18),textAlign: TextAlign.center,))),
            DataColumn(label: Text('Stocks', style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
          ],
          rows: provider.componentes.map<DataRow>((componente) {
            return DataRow(
              cells: [
                DataCell(Center(child: Text(componente['IdComponente'].toString()))),
                DataCell(Center(child: Text(componente['nombre'].toString(),textAlign: TextAlign.center,))),
                DataCell(Center(child: Text(componente['cantidad'].toString()))),
              ],
              onSelectChanged: (bool? selected) {
                if (selected ?? false) {
                  showOptionsDialog(context, componente,
                      Provider.of<ProductProvider>(context, listen: false));
                }
              },
            );
          }).toList(),
        ),
          ],
        );
      },
    );
  }

  void showOptionsDialog(BuildContext context, Map<String, dynamic> component,
      ProductProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Seleccione una opción'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showEditDialog(context, component, provider);
              },
              child: const Text('Actualizar'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                provider.deleteComponetns(component['IdComponente']);
              },
              child: const Text('Borrar'),
            ),
           
          ],
        );
      },
    );
  }

  void showEditDialog(BuildContext context, Map<String, dynamic> product,
      ProductProvider provider) {
    TextEditingController nameController =
        TextEditingController(text: product['nombre']);
    TextEditingController quantityController =
        TextEditingController(text: product['cantidad'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Componente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Stocks'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                provider.updateComponents(
                  product['IdComponente'],
                  nameController.text,
                  int.parse(quantityController.text),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: const Text('Actualizar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
