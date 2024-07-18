import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontendapp/presentation/children/graficalineal_child.dart';
import 'package:frontendapp/presentation/providers/regression_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontendapp/presentation/util/navigation_util.dart';

class LinearRegressionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegressionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Regresión lineal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: provider.countController,
              decoration: InputDecoration(labelText: 'Ingresar números de pares'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onSubmitted: (value) {
                int? count = int.tryParse(value);
                if (count != null && count > 0) {
                  provider.generateFields(count);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content:
                          Text('Ingresar valor mayor a 0.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.xControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: provider.xControllers[index],
                          decoration:
                              InputDecoration(labelText: 'x${index + 1}'),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: provider.yControllers[index],
                          decoration:
                              InputDecoration(labelText: 'y${index + 1}'),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                provider.calculateLinearRegression(context);
                if(!provider.error){
                  navigatioUtil.navigateToScreen(
                    context, LinearRegressionScreen1());
                }
                
              },
              // ignore: prefer_const_constructors
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
