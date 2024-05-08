import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:graphview/GraphView.dart';
import 'package:provider/provider.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider watch = context.watch<ProductProvider>();
    return Consumer<ProductProvider>(builder: (context, provider, child) {
   
      return Scaffold(
        appBar: AppBar(
          title: Text('Producto: ${provider.prd.firstWhere((element) => element.idProducto == provider.IdProducto).nombre}'),
          
        ),
        body:  InteractiveViewer(
            transformationController: provider.transformationController,
              //alignment: Alignment.topCenter,
              constrained: false,
              boundaryMargin: const EdgeInsets.all(300),
              minScale: 0.01,
              maxScale: 2.6,
              child: GraphView(
                graph: watch.graph,
                algorithm: BuchheimWalkerAlgorithm(
                    watch.builder, TreeEdgeRenderer(watch.builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key?.value as String;

                  return rectangleWidget(a);
                },
              )),
       
        
      );
    });
  }
   Widget rectangleWidget(String a) {
    return InkWell(
      onTap: () {},
      child: Container(
          
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 197, 229, 255), spreadRadius: 1),
            ],
          ),
          child: Text(
            a,
            style: const TextStyle(fontSize: 15),
          )),
    );
  }
}

