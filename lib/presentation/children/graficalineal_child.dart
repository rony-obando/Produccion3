import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontendapp/presentation/providers/regression_provider.dart';
import 'package:provider/provider.dart';

class LinearRegressionScreen1 extends StatelessWidget {
  const LinearRegressionScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfica de Regresión Lineal'),
      ),
      body: Stack(
        children: [
          const ScrollableGraphWidget(),
          const MovableTextWidget(),
        ],
      ),
    );
  }
}

class ScrollableGraphWidget extends StatelessWidget {
  const ScrollableGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RegressionProvider watch = context.watch<RegressionProvider>();
    final List<FlSpot> scatterData = context.read<RegressionProvider>().scatterData(context);

    final double a = watch.b1; // Pendiente
    final double b = watch.b0; // Intercepto
    double maxy = scatterData.reduce((current, next) => current.y > next.y ? current : next).y;
    double maxx = scatterData.reduce((current, next) => current.x > next.x ? current : next).x;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 600, // Ajusta el ancho según sea necesario
          height: 600, // Ajusta la altura según sea necesario
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 50, showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 40, showTitles: true),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 40, showTitles: true),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 40, showTitles: true),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black, width: 1),
              ),
              minX: 0,
              maxX: maxx != maxx.floor()? maxx*1.15: (maxx*1.15).round().toDouble(),
              minY: 0,
              maxY: maxy != maxy.floor()? maxy*1.15: (maxy*1.15).round().toDouble(),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(scatterData.length, (index) {
                    final x = scatterData[index].x;
                    final y = a * x + b;
                    return FlSpot(x, y);
                  }),
                  isCurved: false,
                  color: Colors.red,
                  barWidth: 2,
                  dotData: FlDotData(show: true),
                ),
                LineChartBarData(
                  spots: List.generate(scatterData.length, (index) {
                    int i = index;
                    return FlSpot(
                      scatterData[(i + 1) > scatterData.length - 1 ? index : i + 1].x,
                      scatterData[(i + 1) > scatterData.length - 1 ? index : i + 1].y,
                    );
                  }),
                  isCurved: false,
                  color: Colors.blue,
                  barWidth: 0,
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovableTextWidget extends StatefulWidget {
  const MovableTextWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovableTextWidgetState createState() => _MovableTextWidgetState();
}

class _MovableTextWidgetState extends State<MovableTextWidget> {
  Offset position = const Offset(16, 16); // Posición inicial del texto

  @override
  Widget build(BuildContext context) {
    RegressionProvider watch = context.watch<RegressionProvider>();
    final double a = watch.b1; // Pendiente
    final double b = watch.b0; // Intercepto
    final String formula = 'y = ${a.toStringAsFixed(2)}x + ${b.toStringAsFixed(2)}';

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Text(
            formula,
            
            style: const TextStyle(
              color: Color.fromARGB(255, 194, 29, 17),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color.fromARGB(255, 194, 29, 17), 
              
            ),
          ),
        ),
      ),
    );
  }
}
