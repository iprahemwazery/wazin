import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/transaction_provider.dart';

class WeeklyBarChart extends StatefulWidget {
  const WeeklyBarChart({super.key});

  @override
  State<WeeklyBarChart> createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  DateTime selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.transactionsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final txs = snapshot.data!;
        final weekly = _splitWeeks(txs, selectedMonth);

        // تحقق لو مفيش بيانات
        final hasData = weekly.any((w) => w["income"]! + w["expense"]! > 0);

        if (!hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No data for ${selectedMonth.month}/${selectedMonth.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedMonth = DateTime.now();
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Go Back"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

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

        return Center(
          child: Container(
            height: 380,
            width: 340,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 247, 240),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                // الأسهم والشهر
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18),
                        onPressed: () {
                          setState(() {
                            selectedMonth = DateTime(
                              selectedMonth.year,
                              selectedMonth.month - 1,
                            );
                          });
                        },
                      ),
                      const Spacer(),
                      Text(
                        "${selectedMonth.month}/${selectedMonth.year}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color:
                              (selectedMonth.month == DateTime.now().month &&
                                      selectedMonth.year == DateTime.now().year)
                                  ? Colors.grey
                                  : Colors.black,
                        ),
                        onPressed:
                            (selectedMonth.month == DateTime.now().month &&
                                    selectedMonth.year == DateTime.now().year)
                                ? null
                                : () {
                                  setState(() {
                                    selectedMonth = DateTime(
                                      selectedMonth.year,
                                      selectedMonth.month + 1,
                                    );
                                  });
                                },
                      ),
                    ],
                  ),
                ),

                // الرسم البياني
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 8.0),
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: List.generate(weekly.length, (i) {
                          final income = weekly[i]["income"]!;
                          final expense = weekly[i]["expense"]!;
                          if (income == 0 && expense == 0)
                            return BarChartGroupData(x: i, barRods: []);

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
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 0,
                                  color: Colors.transparent,
                                ),
                              ),
                              BarChartRodData(
                                toY: expense,
                                color: CustomColors.blue,
                                width: 12,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 0,
                                  color: Colors.transparent,
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
                                if (value.toInt() >= weekLabels.length)
                                  return const SizedBox();
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
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static List<Map<String, double>> _splitWeeks(
    List<Map<String, dynamic>> txs,
    DateTime month,
  ) {
    List<Map<String, double>> weeks = [
      {"income": 0.0, "expense": 0.0},
      {"income": 0.0, "expense": 0.0},
      {"income": 0.0, "expense": 0.0},
      {"income": 0.0, "expense": 0.0},
    ];

    for (var tx in txs) {
      DateTime date;
      if (tx['date'] is Timestamp) {
        date = (tx['date'] as Timestamp).toDate();
      } else {
        date = DateTime.tryParse(tx['date'].toString()) ?? DateTime.now();
      }

      if (date.month != month.month || date.year != month.year) continue;

      int day = date.day;
      int weekIndex = (day - 1) ~/ 7;
      if (weekIndex < 0 || weekIndex > 3) continue;

      double amount = 0.0;
      final rawAmount = tx["amount"];
      if (rawAmount is num) {
        amount = rawAmount.toDouble();
      } else {
        amount = double.tryParse(rawAmount.toString()) ?? 0.0;
      }

      if (amount >= 0) {
        weeks[weekIndex]["income"] = weeks[weekIndex]["income"]! + amount;
      } else {
        weeks[weekIndex]["expense"] =
            weeks[weekIndex]["expense"]! + amount.abs();
      }
    }

    return weeks;
  }
}
