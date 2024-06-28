import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/methods/planeacion_methods.dart';
import 'package:frontendapp/presentation/children/planeacionchart_child.dart';
import 'package:frontendapp/presentation/providers/planeacion_provider.dart';
import 'package:frontendapp/presentation/screens/ltc_luc_sreen.dart';
import 'package:provider/provider.dart';
import 'package:frontendapp/presentation/util/navigation_util.dart';

class DataEntryScreen extends StatelessWidget {
  DataEntryScreen({super.key});

  //final _formKey = GlobalKey<FormState>();

  List<int> _demandas = List.filled(12, 0);
  List<double> _diasProduccion = List.filled(12, 0);

  @override
  Widget build(BuildContext context) {
    PlaneacioProvider watch = context.watch<PlaneacioProvider>();
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Datos de Producción',
          textAlign: TextAlign.center,
        )),
        body: Center(
          child: SizedBox(
            width: 200,
            child: Form(
              //    key: _formKey,
              child: ListView(
                children: [
                  const Center(
                    child: Text('Número de períodos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      initialValue: watch.meses.toString(),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa el número de períodos';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<PlaneacioProvider>().setPlanProps(
                            meses: int.parse(value.isEmpty ? '0' : value));
                        _demandas.length  = int.parse(value.isEmpty ? '0' : value);
                        _diasProduccion.length = int.parse(value.isEmpty ? '0' : value);
                      },
                    ),
                  ),
                  
                  for (int i = 0; i < watch.meses; i++) ...[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: Text((i+1).toString(),style: const TextStyle(fontWeight: FontWeight.bold),),),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Número defectosos',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _demandas[i] = int.parse(value.isEmpty ? '0' : value);
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa la demanda';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Fracción defectuosa',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      onChanged: (value) {
                        _diasProduccion[i] =
                            double.parse(value.isEmpty ? '0' : value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa los días de producción';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  const Center(
                    child: Text('q (%)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      initialValue: watch.meses.toString(),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa q';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<PlaneacioProvider>().setPlanProps(
                            meses: int.parse(value.isEmpty ? '0' : value));
                        _demandas.length  = int.parse(value.isEmpty ? '0' : value);
                        _diasProduccion.length = int.parse(value.isEmpty ? '0' : value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<PlaneacioProvider>().setPlanProps(
                          fraccion: _diasProduccion, nmDefectuosos: _demandas);
                      //navigatioUtil.navigateToScreen(context,PlaneacionCharts(data: getPlaneacions(watch.meses,watch.monthNames,watch.demandas,watch.diasProduccion)));
                      navigatioUtil.navigateToScreen(
                          context, FractionDefectuosaChart());
                    },
                    child: const Text('Generar Gráfica'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
