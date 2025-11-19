import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/dataCardHome/widget/chart_header.dart';
import 'package:wazin/features/dataCardHome/widget/week_splitter.dart';
import 'package:wazin/transaction_provider.dart';

import 'weekly_body.dart';

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
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final txs = snapshot.data!;
        final weekly = splitWeeks(txs, selectedMonth);

        final hasData = weekly.any((w) => w["income"]! + w["expense"]! > 0);

        if (!hasData) {
          return _noDataWidget();
        }

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
                WeeklyHeader(
                  selectedMonth: selectedMonth,
                  onPrev:
                      () => setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month - 1,
                        );
                      }),
                  onNext:
                      () => setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month + 1,
                        );
                      }),
                ),

                Expanded(child: WeeklyBody(weekly: weekly)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _noDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No data for ${selectedMonth.month}/${selectedMonth.year}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
}
