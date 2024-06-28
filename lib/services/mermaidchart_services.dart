import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:frontendapp/presentation/util/addunion_util.dart';
import 'package:frontendapp/presentation/widgets/loading_widget.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {    
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
          return const LoadingImage(
            imageUrl: 'assets/icon/logouni12.png',
          );
        }else{
          return Scaffold(
        appBar: AppBar(
          title: Text(
              'Producto: ${provider.prd.firstWhere((element) => element.idProducto == provider.IdProducto).nombre}'),
        ),
        body: InteractiveViewer(
            transformationController: provider.transformationController,
            constrained: false,
      boundaryMargin: const EdgeInsets.all(300),
      minScale: 0.01,
      maxScale: 2.6,
          
            child: GraphView(
              graph: provider.graph,
              algorithm: SugiyamaAlgorithm(
                provider.builder
              ),
              builder: (Node node) {
                var a = node.key?.value as String;
                return rectangleWidget(a,context,node);
              },
            ),
          ),
      
      );
        }

      
    });
  }

  Widget rectangleWidget(String a, BuildContext context, node) {
    ProductProvider watch1 = context.watch<ProductProvider>();
    return InkWell(
      onLongPress: () {
        
      },
       onTapUp: (details) => _showMenu(context, details.globalPosition, a, watch1,node),
      child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 229, 255), spreadRadius: 1),
            ],
          ),
          child: Text(
            watch1.nombres.where((element) => element.contains(a)).isEmpty?a:watch1.nombres.where((element) => element.contains(a)).first,
            style: const TextStyle(fontSize: 15),
          )),
    );
  }
   void _showMenu(BuildContext context, Offset position, String text,  ProductProvider watch1, Node node) async {
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        const PopupMenuItem(value: 'Add', child: Text('Agregar Union')),
        const PopupMenuItem(value: 'Delete', child: Text('Borrar union')),
      ],
      
    );

    // Handle menu selection if needed
    if (selected != null) {

      if(selected == 'Add'){
        //context.read<ProductProvider>().addNode(node);
         //context.read<ProductProvider>().refreshGraph();
        
        AddUnionUtil.show(context,text, node);

      }else{
        final nodeName = watch1.getNodeName(node);
        final parentName = watch1.getParentNodeNames(node);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('¿Estas seguro de eliminar el nodo?'),
              //content: Text('Node: $nodeName\nParent: ${parentName.toString()}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    watch1.removeNode(node);
                    context.read<ProductProvider>().deteleUnion(parentName, nodeName!);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Eliminar'),
                ),
               
              ],
            );
          },
        );
      }
    }
  }
  /*void removeNode(Node node) {
    final parent = parentNodeMap[node];
    if (parent != null) {
      setState(() {
        graph.removeNode(node);
        parentNodeMap.remove(node);
        parentNodeMap.removeWhere((key, value) => value == node);
      });
    }
  }*/
}
