// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/children/numberkanban_child.dart';
import 'package:frontendapp/presentation/children/numbrescontainer_child.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:frontendapp/presentation/widgets/Corrective_maintenance.dart';
import 'package:frontendapp/presentation/widgets/eoq_widget.dart';
import 'package:frontendapp/presentation/widgets/inventory_rotation_widget.dart';
import 'package:provider/provider.dart';

class MenuSc extends StatelessWidget {
   MenuSc({super.key});
  late String text = 'Selecciona una opción en el menú.';
  dynamic widg;
  

  @override
  Widget build(BuildContext context) {

    MenusProvider watch = context.watch<MenusProvider>();

    return Scaffold(
      appBar: AppBar (
        leading:  Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
             'assets/icon/logouni12.png',
            
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
               PopupMenuItem(
                value: rotation_widget(),
                child: const Text('Inventario Promedio'),
              ),
               const PopupMenuItem(
               value: NumberContainer(),
               child: Text('Cantidad de Recipientes'),
               ),
               const PopupMenuItem(
               value: NumberKanbans(),
               child: Text('Cantidad de Kanbanes'),
               ),
            ],
            onSelected: (value) {
              widg = value;
                context.read<MenusProvider>().setMenusProps(showTextBoxes: true);
            },
          ),
        ],
      ),
      body: SingleChildScrollView( 
            child: watch.showTextBoxes? widg ?? Center(child: Text(text)): Center(
              child: Text(text),
              
            ),
      ),
    );
  }
}
