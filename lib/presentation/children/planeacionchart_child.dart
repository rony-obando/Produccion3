import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';

class FractionDefectuosaChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    const List<FlSpot> data = [
      FlSpot(1, 0.04),
      FlSpot(2, 0.00),
      FlSpot(3, 0.01),
      FlSpot(4, 0.02),
      FlSpot(5, 0.08),
      FlSpot(6, 0.05),
      FlSpot(7, 0.01),
      FlSpot(8, 0.00),
      FlSpot(9, 0.04),
      FlSpot(10, 0.08),
      FlSpot(11, 0.05),
      FlSpot(12, 0.02),
    ];

    return Container(
     // height: 400, // Ajusta el tamaño del contenedor según sea necesario
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 40),
      color: Colors.white, // Establece el color de fondo del contenedor a blanco
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.white, // Establece el color de fondo del gráfico a blanco
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 0.1,
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 0.01,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  );
                },
                reservedSize: 30, // Ajusta el tamaño reservado para los títulos del eje izquierdo
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
                reservedSize: 22, // Ajusta el tamaño reservado para los títulos del eje inferior
              ),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.black)),
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: data,
              isCurved: false,
              barWidth: 2,
              color: Colors.blue,
              dotData: FlDotData(show: true),
            ),
          ],
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: 0.06, // Valor de la línea LSC
                color: Colors.red,
                strokeWidth: 2,
                dashArray: [5, 5], // Línea punteada, elimina esta línea para una línea sólida
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topRight,
                  labelResolver: (line) => 'LSC = ${line.y.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              HorizontalLine(
                y: 0.01, // Valor de la línea LSC
                color: Colors.red,
                strokeWidth: 2,
                dashArray: [5, 5], // Línea punteada, elimina esta línea para una línea sólida
                label: HorizontalLineLabel(
                  show: true,
                  alignment: Alignment.topRight,
                  labelResolver: (line) => 'LIC = ${line.y.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}