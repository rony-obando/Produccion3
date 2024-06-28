import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/children/componentes_child.dart';
import 'package:frontendapp/presentation/providers/login_provider.dart';
import 'package:frontendapp/presentation/providers/menus_provider.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/methods/mrp_screen.dart';
import 'package:frontendapp/presentation/widgets/addComponentes.dart';
import 'package:frontendapp/presentation/widgets/addProductos.dart';
import 'package:frontendapp/presentation/widgets/addunions.dart';
import 'package:frontendapp/presentation/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MrpScreen extends StatelessWidget {
   MrpScreen({super.key});
   dynamic widg;
    String text = 'Selecciona una opción en el menú.';
    
  @override
  Widget build(BuildContext context) {
    context.read<ProductProvider>().setUsuario(context.watch<LoginProvider>().idUsuario);
     MenusProvider watch = context.watch<MenusProvider>();
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LoadingImage(
            imageUrl: 'assets/icon/logouni12.png',
          );
        }
        
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset('assets/icon/logouni12.png'),
            ),
            title: const Text('Inventario', style: TextStyle(fontSize: 25)),
            centerTitle: true,
            actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  value: DataTableWidget(),
                  child: Text('Productos'),
                ),
                const PopupMenuItem(
                  value: addProductos(),
                  child: Text('Agregar productos'),
                ),
                const PopupMenuItem(
                  value: ComponenteTable(),
                  child: Text('Componentes'),
                ),
                const PopupMenuItem(
                  value: AddComponent(),
                  child: Text('Agregar componentes'),
                ),
                 PopupMenuItem(
                  onTap: () {
                    context.read<ProductProvider>().setProductprops(text1: '');
                    context.read<ProductProvider>().setProductprops(cantidad: 0);
                  },
                  value: const AddProductos(),
                  child: const Text('Agregar Uniones'),
                ),
              ],
              onSelected: (value) {
                widg = value;
                context.read<MenusProvider>().setMenusProps(showMrpMenu: true);
              },
            ),
          ],
          
          ),
          body: SingleChildScrollView( 
            child: watch.showMrpMenu? widg ?? Center(child: Text(text)):  Center(
              child: Text(text),
            ),
        ));
      },
    );
  }
}
