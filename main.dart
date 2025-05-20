import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const GoldApp());
}

class GoldApp extends StatelessWidget {
  const GoldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GoldChartScreen(),
    );
  }
}

class GoldChartScreen extends StatefulWidget {
  const GoldChartScreen({super.key});

  @override
  State createState() => _GoldChartScreenState();
}

class _GoldChartScreenState extends State {
  final List<double> prices = [2500000, 2520000, 2510000, 2550000, 2570000, 2580000, 2540000, 2590000];
  final List<double?> maShort = [null, null, 2510000, 2526666, 2543333, 2566666, 2563333, 2570000];
  final List<int> buySignals = [3, 7];
  final List<int> sellSignals = [6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحلیل طلا")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: prices
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value / 1000000))
                    .toList(),
                isCurved: true,
                barWidth: 3,
                color: Colors.blue,
                dotData: FlDotData(show: false),
              ),
              LineChartBarData(
                spots: maShort
                    .asMap()
                    .entries
                    .where((e) => e.value != null)
                    .map((e) => FlSpot(e.key.toDouble(), e.value! / 1000000))
                    .toList(),
                isCurved: true,
                barWidth: 2,
                color: Colors.orange,
                dotData: FlDotData(show: false),
              ),
            ],
            lineTouchData: LineTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            showingTooltipIndicators: [],
            extraLinesData: ExtraLinesData(
              verticalLines: [
                for (int index in buySignals)
                  VerticalLine(
                    x: index.toDouble(),
                    color: Colors.green,
                    strokeWidth: 2,
                    dashArray: [4, 2],
                  ),
                for (int index in sellSignals)
                  VerticalLine(
                    x: index.toDouble(),
                    color: Colors.red,
                    strokeWidth: 2,
                    dashArray: [4, 2],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}