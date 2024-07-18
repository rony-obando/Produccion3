// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/providers/kanbanes_provider.dart';
import 'package:frontendapp/presentation/util/getcapacidades_util.dart';
import 'package:frontendapp/presentation/util/getdemandas.dart';
import 'package:frontendapp/presentation/util/getofertas_util.dart';
import 'package:frontendapp/presentation/util/gettiempos_util.dart';
import 'package:frontendapp/presentation/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';

const route = '/notification-save';

class NumberKanbans extends StatelessWidget {
  const NumberKanbans({super.key});

  @override
  Widget build(BuildContext context) {
    KanbanesProvider watch = context.watch<KanbanesProvider>();

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
              minWidth: 100,
            ),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (text) {
                context.read<KanbanesProvider>().setPeriodos(
                    seguridad:
                        double.tryParse(text.isEmpty ? 0.toString() : text)!);
              },
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
              decoration: const InputDecoration(
                labelText: 'Stock de seguridad',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
              minWidth: 100,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (text) {
                context.read<KanbanesProvider>().setPeriodos(
                    periodos:
                        int.tryParse(text.isEmpty ? 0.toString() : text)!);
                        context.read<KanbanesProvider>().updateControllers();
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Cantidad de período',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Agregar demandas',
            size: const Size(250, 50),
            color: const Color.fromARGB(255, 197, 229, 255),
            rounded: 10,
            function: () {
              try {
                GetDemandas.show(context);
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          Text(
                            'Error',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: Text(
                        e.toString(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            fontSize: 18,
            padding: 0,
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Agregar ofertas',
            size: const Size(250, 50),
            color: const Color.fromARGB(255, 197, 229, 255),
            rounded: 10,
            function: () {
              try {
                GetOfertas.show(context);
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          Text(
                            'Error',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: Text(
                        e.toString(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            fontSize: 18,
            padding: 0,
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Capacidades de almacenaje',
            size: const Size(250, 50),
            color: const Color.fromARGB(255, 197, 229, 255),
            rounded: 10,
            function: () {
              try {
                GetCapacidades.show(context);
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          Text(
                            'Error',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: Text(
                        e.toString(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            fontSize: 16,
            padding: 0,
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            text: 'Tiempos de entrega',
            size: const Size(250, 50),
            color: const Color.fromARGB(255, 197, 229, 255),
            rounded: 10,
            function: () {
              try {
                GetTiempos.show(context);
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Row(
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          Text(
                            'Error',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: Text(
                        e.toString(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cerrar',
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            fontSize: 18,
            padding: 0,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              try {
                Navigator.pushNamed(context, 'Kanbanes');
                    
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 215, 172, 169),
                      title: const Text('Error'),
                      content: Text('$e!!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Calcular'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
