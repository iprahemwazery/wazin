import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wazin/core/custom_colors.dart';

class WeeklyBody extends StatelessWidget {
  final List<Map<String, double>> weekly;

  const WeeklyBody({super.key, required this.weekly});

  @override
  Widget build(BuildContext context) {
    final weekLabels = ['W1', 'W2', 'W3', 'W4'];

    double maxY =
        weekly.fold<double>(
          0.0,
          (prev, e) =>
              prev > (e["income"]! + e["expense"]!)
                  ? prev
                  : (e["income"]! + e["expense"]!),
        ) *
        1.2;

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 8.0),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          barGroups: List.generate(weekly.length, (i) {
            final income = weekly[i]["income"]!;
            final expense = weekly[i]["expense"]!;

            if (income == 0 && expense == 0) {
              return BarChartGroupData(x: i, barRods: []);
            }

            return BarChartGroupData(
              x: i,
              barsSpace: 8,
              barRods: [
                BarChartRodData(
                  toY: income,
                  color: CustomColors.green,
                  width: 12,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: expense,
                  color: CustomColors.blue,
                  width: 12,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= weekLabels.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      weekLabels[value.toInt()],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget:
                    (value, meta) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: maxY / 5,
            getDrawingHorizontalLine:
                (value) => FlLine(
                  color: Colors.black.withOpacity(0.3),
                  strokeWidth: 0.6,
                  dashArray: [4, 3],
                ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
              top: BorderSide.none,
              right: BorderSide.none,
            ),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 1200),
        swapAnimationCurve: Curves.easeOutCubic,
      ),
    );
  }
}
