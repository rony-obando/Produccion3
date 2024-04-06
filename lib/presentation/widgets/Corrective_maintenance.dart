// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';

const route = '/notification-save';

class CorrMain extends StatefulWidget {
  const CorrMain({super.key});

  @override
  // ignore: library_private_types_in_public_api
  CorrectiveMaintenance createState() => CorrectiveMaintenance();
}

class CorrectiveMaintenance extends State<CorrMain> {
  double numerofallas = 0;
  double duraciontarea = 0;
  double costohoratrabajo = 0;
  double respuestos = 0;
  double costooperacionales = 0;
  double retrasologistico = 0;
  double costoparada = 0;
  double costofallaunica = 0;
  double resultado = 0;
  bool showAdditionalFields = false;
  @override
  Widget build(BuildContext context) {
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
              const Text('Calcular el número de fallas',style: TextStyle(fontSize: 17),),
              Checkbox(
                value: showAdditionalFields,
                onChanged: (value) {
                  setState(() {
                    showAdditionalFields = value!;
                  });
                },
              ),
            ],
          ),
          if (!showAdditionalFields)
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  try {
                    numerofallas = double.tryParse(text)!;
                    // ignore: empty_catches
                  } catch (e) {}
                });
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Numero de fallas',
                border: OutlineInputBorder(),
              ),
            )
          else
            const AdditionalFields(),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  duraciontarea = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Duración de la tarea (horas)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  costohoratrabajo = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costo por hora de trabajo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  respuestos = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Repuestos',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  costooperacionales = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costo de tareas operacionales',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (text) {
              setState(() {
                try {
                  retrasologistico = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              labelText: 'Retraso logístico (horas)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  costoparada = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costo unitario por parada (/hora)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (text) {
              setState(() {
                try {
                  costofallaunica = double.tryParse(text)!;
                  // ignore: empty_catches
                } catch (e) {}
              });
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Costos de falla de vez única',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (showAdditionalFields) {
                  resultado = Calcular_Resultado(
                      numero_fallas(horasmantenimiento, mtbf),
                      duraciontarea,
                      costohoratrabajo,
                      respuestos,
                      costooperacionales,
                      retrasologistico,
                      costoparada,
                      costofallaunica,
                      resultado);
                } else {
                  resultado = Calcular_Resultado(
                      numerofallas,
                      duraciontarea,
                      costohoratrabajo,
                      respuestos,
                      costooperacionales,
                      retrasologistico,
                      costoparada,
                      costofallaunica,
                      resultado);
                }
              });
              show_result_widget.show(context, 'Mantenimiento Correctivo',
                  'El resultado es: $resultado', resultado);
            },
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

int horasmantenimiento = 0;
double mtbf = 0;

class AdditionalFields extends StatefulWidget {
  const AdditionalFields({super.key});

  @override
  State<AdditionalFields> createState() => _AdditionalFieldsState();
}

class _AdditionalFieldsState extends State<AdditionalFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (text) {
            setState(() {
              try {
                horasmantenimiento = int.tryParse(text)!;
                // ignore: empty_catches
              } catch (e) {}
            });
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: const InputDecoration(
            labelText: 'Horas sobre el mantenimiento',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (text) {
            setState(() {
              try {
                mtbf = double.tryParse(text)!;
                // ignore: empty_catches
              } catch (e) {}
            });
          },
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: const InputDecoration(
            labelText: 'MTBF',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
