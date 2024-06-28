import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/children/ltc_child.dart';
import 'package:frontendapp/presentation/children/luc_child.dart';
import 'package:frontendapp/presentation/providers/ltc_luc_provider.dart';
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
    LtcLucProvider watch = context.watch<LtcLucProvider>();

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
          Consumer<LtcLucProvider>(
            builder: (context, drawerState, child) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
      ),
      body: Consumer<LtcLucProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const SingleChildScrollView(
              child: Center(
            child: Text('Agregue datos al menú lateral'),
          ));
        }
        return watch.widg;
      }),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Container(
        
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Center(
                    child: Text(
                      'Agregar datos',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 236, 233, 233)),
                    ),
                  )
                    ],
                  )
                  ),
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
                        onChanged: (text) {
                          context.read<LtcLucProvider>().setLTCLUCProps(
                              costoorden: double.tryParse(text));
                        },
                        controller: watch.getControllerorden,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
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
                        onChanged: (text) {
                          context.read<LtcLucProvider>().setLTCLUCProps(
                              costomanten: double.tryParse(text));
                        },
                        controller: watch.getController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
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
                        onChanged: (text) {
                          context
                              .read<LtcLucProvider>()
                              .setLTCLUCProps(periodos: int.tryParse(text));
                          context.read<LtcLucProvider>().updateControllers();
                        },
                        controller: watch.getcontrollerperido,
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
                      const SizedBox(height: 20),
                      Container(
                        width: 150,
                        child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
                              text: 'LUC',
                              size: const Size(60, 50),
                              color: const Color.fromARGB(255, 197, 229, 255),
                              rounded: 0,
                              function: () {
                                context
                                    .read<LtcLucProvider>()
                                    .setLTCLUCProps(widg: const LUCchild());
                                context.read<LtcLucProvider>().changeLoading();
                              },
                              fontSize: 15,
                              padding: 10,
                            ),
                           
                            ButtonWidget(
                              text: 'LTC',
                              size:  MediaQuery.of(context).orientation == Orientation.portrait? const Size(60, 50): const Size(80, 70),
                              color: const Color.fromARGB(255, 197, 229, 255),
                              rounded: 0,
                              function: () {
                                context
                                    .read<LtcLucProvider>()
                                    .setLTCLUCProps(widg: const LTCChild());
                                context.read<LtcLucProvider>().changeLoading();
                              },
                              fontSize: 15,
                              padding: 10,
                            ),
                          ],
                        ),
                      ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
