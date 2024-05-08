// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/calculations/CMcalculation.dart';
import 'package:frontendapp/presentation/providers/Mc_provider.dart';
import 'package:frontendapp/presentation/widgets/show_result_widget.dart';
import 'package:provider/provider.dart';

const route = '/notification-save';

class CorrMain extends StatelessWidget {
  const CorrMain({super.key});

  @override
  // ignore: library_private_types_in_public_api
  Widget build(BuildContext context) {

    Mc_provider watch = context.watch<Mc_provider>(); 
    double resultado = 0;

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
                value: watch.showAdditionalFields,
                onChanged: (value) {
                  context.read<Mc_provider>().setCMprops(showAdditionalFields: value);
                },
              ),
            ],
          ),
          if (!watch.showAdditionalFields)
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) {
                context.read<Mc_provider>().setCMprops(numerofallas: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(duraciontarea: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(costohoratrabajo: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(respuestos: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(costooperacionales: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(retrasologistico: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(costoparada: double.tryParse(text.toString()));
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
              context.read<Mc_provider>().setCMprops(costofallaunica: double.tryParse(text.toString()));
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
                if (watch.showAdditionalFields) {
                  resultado = Calcular_Resultado(
                      numero_fallas(watch.horasmantenimiento, watch.mtbf),
                      watch.duraciontarea,
                      watch.costohoratrabajo,
                      watch.respuestos,
                      watch.costooperacionales,
                      watch.retrasologistico,
                      watch.costoparada,
                      watch.costofallaunica,
                      watch.resultado);
                } else {
                  resultado = Calcular_Resultado(
                      watch.numerofallas,
                      watch.duraciontarea,
                      watch.costohoratrabajo,
                      watch.respuestos,
                      watch.costooperacionales,
                      watch.retrasologistico,
                      watch.costoparada,
                      watch.costofallaunica,
                      watch.resultado);
                }
              show_result_widget.show(context, 'CM',
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

class AdditionalFields extends StatelessWidget {
  const AdditionalFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (text) {
            context.read<Mc_provider>().setCMprops(horasmantenimiento: int.tryParse(text.toString()));
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
            context.read<Mc_provider>().setCMprops(mtbf: double.tryParse(text.toString()));
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
