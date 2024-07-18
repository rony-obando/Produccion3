import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';

class DemandaChild extends StatefulWidget {
  const DemandaChild({super.key});

  @override
  _DemandaChildState createState() => _DemandaChildState();
}

class _DemandaChildState extends State<DemandaChild> {
  bool isVertical = true;
  
  @override
  Widget build(BuildContext context) {
    ProductProvider watch = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demanda del Producto'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      initialValue: context.watch<ProductProvider>().demanda.toString(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (text) {
                        context
                            .read<ProductProvider>()
                            .setDemanda(int.tryParse(text));
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
                  ButtonWidget(
                    text: 'Agregar demanda',
                    size: const Size(150, 62),
                    color: const Color.fromARGB(255, 197, 229, 255),
                    rounded: 0,
                    function: () {
                      context.read<ProductProvider>().ShowDemanda(provider.IdProducto);
                    },
                    fontSize: 15,
                    padding: 0,
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx.abs() > details.delta.dy.abs()) {
                      setState(() {
                        isVertical = false;
                      });
                    } else {
                      setState(() {
                        isVertical = true;
                      });
                    }
                  },
                  child: isVertical
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Nombre',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Calculo',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Resultado',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                              rows: provider.dems.map<DataRow>((product) {
                                return DataRow(
                                  selected: false,
                                  cells: [
                                    DataCell(Center(
                                        child: Text(product.nombre.toString()))),
                                    DataCell(Center(
                                        child: Text(product.calculo.toString(),
                                            textAlign: TextAlign.center))),
                                    DataCell(Center(
                                        child: Text(product.resultado.toString()))),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Nombre',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Calculo',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Resultado',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                              rows: provider.dems.map<DataRow>((product) {
                                return DataRow(
                                  selected: false,
                                  cells: [
                                    DataCell(Center(
                                        child: Text(product.nombre.toString()))),
                                    DataCell(Center(
                                        child: Text(product.calculo.toString(),
                                            textAlign: TextAlign.center))),
                                    DataCell(Center(
                                        child: Text(product.resultado.toString()))),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                ),
              ),
              
              Center(child: Text('Demanda promedio: ${context.watch<ProductProvider>().getdemandaprom()}',style: TextStyle(),textAlign: TextAlign.center,),),
              SizedBox(height: 40,)
            ],
          );
        },
      ),
    );
  }
}
