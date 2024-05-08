import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/children/ltc_child.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:frontendapp/presentation/util/getperiodos_util.dart';
import 'package:frontendapp/presentation/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LTCLUCScreen extends StatelessWidget {
  LTCLUCScreen({super.key});

  late String text = 'LTC';
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
        title: const Text('Manejo de inventario'),
        actions: [
          Consumer<MenusProvider>(
            builder: (context, drawerState, child) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          /*  const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                itemCount: watch.numberOfPeriods,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextField(
                      //controller: controllers[index],
                      decoration:
                          InputDecoration(labelText: 'Input ${index + 1}'),
                    ),
                    /* trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () => _removeTextField(index),
            ),*/
                  );
                },
              ), /*ListView.builder(
                  itemCount: watch.numberOfPeriods,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Cantidad para el período ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final quantity = int.tryParse(value) ?? 0;
                          context
                              .read<MenusProvider>()
                              .setQuantity(index, quantity);
                        },
                      ),
                      ),
                    );
                  },
                ),*/
            ),
            SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      children: [
                        TextField(
                          expands: false,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {},
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Demanda',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      ButtonWidget(
                        text: 'LTC',
                        size: const Size(60, 60),
                        color: const Color.fromARGB(255, 197, 229, 255),
                        rounded: 10,
                        function: () {},
                        fontSize: 15,
                        padding: 0,
                      ),
                      const SizedBox(width: 20),
                      ButtonWidget(
                        text: 'LUC',
                        size: const Size(60, 60),
                        color: const Color.fromARGB(255, 197, 229, 255),
                        rounded: 10,
                        function: () {},
                        fontSize: 15,
                        padding: 0,
                      ),
                    ],
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: LTCchild(),
                  ),
                ],
              ),
            )*/
        ],
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Container(
          //width: MediaQuery.of(context).size.width / 3,
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menú Lateral'),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03),
                  child: Column(
                    children: [
                      TextField(
                        expands: false,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {},
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Costo de ordenar',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        expands: false,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {},
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Costo de Mantenimiento',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        expands: false,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {},
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Número de Período',
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        text: 'Agregar unidades',
                        size: const Size(160, 50),
                        color: const Color.fromARGB(255, 197, 229, 255),
                        rounded: 0,
                        function: () {
                          GetPeridosUtil.show(context);
                        },
                        fontSize: 15,
                        padding: 0,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
