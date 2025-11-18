import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazin/transaction_provider.dart';

class GlobalProgressBar extends StatelessWidget {
  const GlobalProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.transactionsStream(),
      builder: (context, snapshot) {
        double incomePercent = 0;
        double expensePercent = 0;

        if (snapshot.hasData) {
          final txs = snapshot.data!;
          double income = txs
              .where((tx) => tx['amount'] >= 0)
              .fold(0.0, (sum, tx) => sum + tx['amount']);
          double expense = txs
              .where((tx) => tx['amount'] < 0)
              .fold(0.0, (sum, tx) => sum + -tx['amount']);
          double total = income + expense;
          if (total > 0) {
            incomePercent = (income / total).clamp(0.0, 1.0);
            expensePercent = (expense / total).clamp(0.0, 1.0);
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 30,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(30),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: incomePercent,
                    child: Container(height: 30, color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(30),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: expensePercent,
                    child: Container(height: 30, color: Colors.black),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (incomePercent > 0)
                        Text(
                          '${(incomePercent * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      if (expensePercent > 0)
                        Text(
                          '${(expensePercent * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
