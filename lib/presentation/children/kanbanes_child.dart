import 'package:flutter/material.dart';
import 'package:frontendapp/methods/kanbanes_method.dart';
import 'package:frontendapp/presentation/providers/kanbanes_provider.dart';
import 'package:provider/provider.dart';

class KanbanesChild extends StatelessWidget {
  const KanbanesChild({super.key});

  @override
  Widget build(BuildContext context) {
    var watch = context.watch<KanbanesProvider>();
    var list = getKanbanes(watch.demandas, watch.ofertas, watch.tiempoentrega,
        watch.capacidad, watch.seguridad);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
            //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Center(
              child: Text(
                'Cantidad de Kanbanes',
                style: TextStyle(fontSize: 25),
              ),
            )),
      ),
      body: InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(300),
      minScale: 0.01,
      maxScale: 2.6,
      child: Column(
        children: [
          DataTable(
            headingRowHeight: 78.0,
            showCheckboxColumn: false,
            showBottomBorder: true,
            border: const TableBorder(
              top: BorderSide(width: 2.0, color: Colors.black),
              bottom: BorderSide(width: 2.0, color: Colors.black),
              left: BorderSide(width: 2.0, color: Colors.black),
              right: BorderSide(width: 2.0, color: Colors.black),
              horizontalInside: BorderSide(width: 1.0, color: Colors.black),
              verticalInside: BorderSide(width: 1.0, color: Colors.black),
            ),
            columns: const [
              DataColumn(
                  label: Expanded(
                      child: Text(
                'período',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                'Demanda',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                'Tiempo de Entrega',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                'Stock de \n seguridad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                'Capacidad de \n almacenamiento',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                'kanbanes',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ))),
            ],
            rows: list.map<DataRow>((componente) {
              return DataRow(
                cells: [
                  DataCell(Center(
                      child: Text(
                    componente.periodo.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ))),
                  DataCell(Center(
                      child: Text(
                    componente.demanda.toString(),
                    textAlign: TextAlign.center,
                  ))),
                  DataCell(Center(
                      child: Text(
                    componente.tiempoentrega.toString(),
                    textAlign: TextAlign.center,
                  ))),
                  DataCell(Center(
                      child: Text(
                    componente.seguridad.toString(),
                    textAlign: TextAlign.center,
                  ))),
                  DataCell(Center(
                      child: Text(
                    componente.capacidad.toString(),
                    textAlign: TextAlign.center,
                  ))),
                  DataCell(Center(
                      child: Text(
                    componente.kanbanes.toString(),
                    textAlign: TextAlign.center,
                  ))),
                ],
                onSelectChanged: (bool? selected) {
                  if (selected ?? false) {
                    /* showOptionsDialog(context, componente,
                      Provider.of<ProductProvider>(context, listen: false));*/
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20,),
          const Text('Kanbanes Totales:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          const SizedBox(height: 10,),
          Text(totalKanbanes(list).toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
    );
  }
}

