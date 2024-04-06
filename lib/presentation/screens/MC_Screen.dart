
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>  {

  double numerofallas = 0;
  double duraciontarea = 0;
  double costohoratrabajo = 0;
  double respuestos = 0;
  double costooperacionales = 0;
  double retrasologistico = 0;
  double costoparada = 0;
  double costofallaunica = 0;
  double resultado = 0;

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mantenimiento correctivo'),
        ),
        body: SingleChildScrollView(
         child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // Usamos una columna para organizar los TextField verticalmente
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                   keyboardType: TextInputType.number, // Define el tipo de teclado como numérico
                   onChanged: (text) {
                   setState(() {
                     numerofallas = double.tryParse(text)!;
                   });
                  },
                   inputFormatters: <TextInputFormatter>[
                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Permite solo números
                   ],
                  decoration: const InputDecoration(
                    labelText: 'Numero de fallas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     duraciontarea = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Duración de la tarea (horas)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     costohoratrabajo = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Costo por hora de trabajo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     respuestos = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Repuestos',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     costooperacionales = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Costo de tareas operacionales',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                   TextField(
                   keyboardType: TextInputType.number, // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     retrasologistico = double.tryParse(text)!;
                   });
                  },
                   inputFormatters: <TextInputFormatter>[
                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Permite solo números
                   ],
                  decoration: const InputDecoration(
                    labelText: 'Retraso logístico',
                    border: OutlineInputBorder(),
                  ),
                ),
                 const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     costoparada = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Costo unitario por parada (/hora)',
                    border: OutlineInputBorder(),
                  ),
                ),
                 const SizedBox(height: 20), // Añadimos un espacio entre los TextField
                TextField(
                   keyboardType: const TextInputType.numberWithOptions(decimal: true), // Define el tipo de teclado como numérico
                    onChanged: (text) {
                   setState(() {
                     costofallaunica = double.tryParse(text)!;
                   });
                  },
                  inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Permite solo números
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
                    resultado = calcularResultado(numerofallas, duraciontarea, costohoratrabajo, respuestos, costooperacionales, retrasologistico, costoparada, costofallaunica, resultado);
                  });
                },
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 20),
              Text( 'El costo del mantenimiento correctivo es: \$${resultado.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
  
}
 double calcularResultado(
 double numerofallas, 
 double duraciontarea, 
 double costohoratrabajo, 
 double respuestos, 
 double costooperacionales, 
 double retrasologistico, 
 double costoparada, 
 double costofallaunica, 
 double resultado)
  {



    return numerofallas*((duraciontarea*costohoratrabajo+respuestos+costooperacionales)+(numerofallas*costoparada+costofallaunica));
    }
