// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontendapp/config/domain/entities/Componente.dart';
import 'package:frontendapp/config/domain/entities/Producto.dart';
import 'package:frontendapp/config/domain/entities/union.dart';
import 'package:frontendapp/main.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:frontendapp/presentation/screens/Menu_others.dart';
import 'package:frontendapp/presentation/screens/ltc_luc_sreen.dart';
import 'package:frontendapp/presentation/screens/menu_mrp.dart';
import 'package:frontendapp/presentation/util/navigation_util.dart';
import 'package:frontendapp/presentation/widgets/Corrective_maintenance.dart';
import 'package:frontendapp/presentation/widgets/buttons_widget.dart';
import 'package:frontendapp/presentation/widgets/eoq_widget.dart';
import 'package:frontendapp/presentation/widgets/inventory_rotation_widget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class optionsScreen extends StatelessWidget {
  optionsScreen({super.key});
  late String text = 'Selecciona una opción en el menú.';
  dynamic widg;

  @override
  Widget build(BuildContext context) {
    MenusProvider watch = context.watch<MenusProvider>();

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/icon/logouni12.png',
            ),
          ),
          title: const Align(
            alignment: Alignment.center,
            child: Text('Producción 3'),
          ),
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
              ],
              onSelected: (value) {
                widg = value;
                context
                    .read<MenusProvider>()
                    .setMenusProps(showTextBoxes: true);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            SingleChildScrollView(
                child: Center(
                    child: Wrap(
              spacing: 8.0,
              runSpacing: 10.0,
              children: [
                ButtonWidget(
                  text: 'MRP',
                  size: const Size(100, 100),
                  color: Color.fromARGB(255, 197, 229, 255),
                  rounded: 10,
                  function: () {
                    navigatioUtil.navigateToScreen(context,MrpScreen());
                  },
                  fontSize: 20,
                  padding: 0,
                ),
                ButtonWidget(
                  text: 'LUC - LTC',
                  size: const Size(150, 100),
                  color: Color.fromARGB(255, 197, 229, 255),
                  rounded: 10,
                  function: () async {
                    navigatioUtil.navigateToScreen(context,LTCLUCScreen());
                  },
                  fontSize: 18,
                  padding: 0,
                ),
                ButtonWidget(
                  text: 'otros calculos',
                  size: const Size(150, 100),
                  color: Color.fromARGB(255, 197, 229, 255),
                  rounded: 10,
                  function: () {
                    navigatioUtil.navigateToScreen(context,MenuSc());
                  },
                  fontSize: 20,
                  padding: 0,
                ),
                ButtonWidget(
                  text: '?????',
                  size: const Size(100, 100),
                  color: Color.fromARGB(255, 197, 229, 255),
                  rounded: 10,
                  function: () {},
                  fontSize: 20,
                  padding: 0,
                ),
              ],
            ))),
          ],
        ));
  }

}

