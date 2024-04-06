// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/widgets/Corrective_maintenance.dart';
import 'package:frontendapp/presentation/widgets/eoq_widget.dart';
import 'package:frontendapp/presentation/widgets/inventory_rotation_widget.dart';

class MenuSc extends StatefulWidget {
  const MenuSc({super.key});

  @override
  // ignore: library_private_types_in_public_api
  MenuScreen createState() => MenuScreen();
}

class MenuScreen extends State<MenuSc> {

 

  late String text = 'Selecciona una opción en el menú.';
  bool showTextBoxes = false;
  dynamic widg;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        leading:  Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
             'assets/icon/logouni12.png', // Ruta de la imagen en tu proyecto
            
           ),
        ),
        title: const Text('Manejo de inventario'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: CorrMain(),
                child: Text('Mantenimiento correctivo'),
              ),
              const PopupMenuItem(
                value: eoq_widget(),
                child: Text('EOQ'),
              ),
              const PopupMenuItem(
                value: rotation_widget(),
                child: Text('Inventario Promedio'),
              ),
            ],
            onSelected: (value) {
              widg = value;
                setState(() {
                showTextBoxes = true;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView( 
            child: showTextBoxes? widg: Center(
              child: Text(text),
            ),
      ),
    );
  }
}
