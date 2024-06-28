import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/ltc.dart';
import 'package:frontendapp/config/domain/entities/recepcion.dart';
import 'package:frontendapp/methods/luc_ltc.dart';
import 'package:frontendapp/presentation/providers/ltc_luc_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable

class LTCChild extends StatelessWidget {
  const LTCChild({super.key});

  @override
  Widget build(BuildContext context) {
    LtcLucProvider watch = context.watch<LtcLucProvider>();
    List<Ltc> list = lTC(watch.costoorden, watch.costomanten, watch.unidades);
    List<Recepcion> recepcions = getRecepcionLTC(list, watch.unidades);
    Widget _buildTableRow(List<Widget> cells) {
      return Row(
        children: cells,
      );
    }

    Widget buildHeaderCell(String label) {
      return Container(
        width: 150,
        height: 56,
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
        )),
        child: Text(
          label,
        ),
      );
    }

    Widget buildHeaderCellrecepcion(String label, bool eliminar, bool ultimo) {
      return Container(
        width: 150,
        height: 56,
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: ultimo?const BoxDecoration(
                border: Border(
                      bottom: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    ),
              ):(label == 'Recepción Planeada'
            ?  BoxDecoration(
                border: Border.all(color: Colors.black),
              )
            : (eliminar
                ? const BoxDecoration(
                    color: Color.fromARGB(255, 245, 217, 133),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    ),
                  )
                : const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    ),
                  ))),
        child: Text(
          label,
        ),
      );
    }

    Widget buildHeaderCellPeriodo(String label) {
      return Container(
        width: 150,
        height: 56,
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(300),
      minScale: 0.01,
      maxScale: 2.6,
      child: Consumer<LtcLucProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const Text(
                'MÉTODO DEL MENOR COSTO TOTAL LTC',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  _buildTableRow(
                    [
                      buildHeaderCellPeriodo('Periodo'),
                      for (var recepcion in recepcions)
                        buildHeaderCellPeriodo(recepcion.periodo.toString()),
                    ],
                  ),
                  _buildTableRow(
                    [
                      buildHeaderCell('Requerimiento Bruto'),
                      for (var recepcion in recepcions)
                        buildHeaderCell(recepcion.requerimiento.toString()),
                    ],
                  ),
                  _buildTableRow(
                    [
                      buildHeaderCellrecepcion(
                          'Recepción Planeada', false, false),
                      for (var recepcion in recepcions)
                        buildHeaderCellrecepcion(
                            recepcion.recepcion == 0
                                ? ''
                                : recepcion.recepcion.toString(),
                            recepcion.recepcion == 0 ? false : true,
                            recepcions.last == recepcion),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
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
                    'Período',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Unidades',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Períodos \n Mantenidos',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Costo de \n mantenimiento',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Costo de \n mantenimiento \nacumulado',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ))),
                ],
                rows: list.map<DataRow>((componente) {
                  return DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (componente.eliminar) {
                        return const Color.fromARGB(255, 233, 22, 22)
                            .withOpacity(0.2);
                      }
                      return Colors.transparent;
                    }),
                    cells: [
                      DataCell(Center(
                          child: Text(
                        componente.periodos.toString(),
                        textAlign: TextAlign.center,
                      ))),
                      DataCell(Center(
                          child: Text(
                        componente.unidadaes.toString(),
                        textAlign: TextAlign.center,
                      ))),
                      DataCell(Center(
                          child: Text(
                        componente.periodoM.toString(),
                        textAlign: TextAlign.center,
                      ))),
                      DataCell(Center(
                          child: Text(
                        componente.costoM.toString(),
                        textAlign: TextAlign.center,
                      ))),
                      DataCell(Center(
                          child: Text(
                        componente.costoMA.toString(),
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
            ],
          );
        },
      ),
    );
  }
}
