import 'package:flutter/material.dart';

class SimpleCheckboxExample extends StatelessWidget {
  final double? income;
  final double? expense;

  const SimpleCheckboxExample({super.key, this.income, this.expense});

  @override
  Widget build(BuildContext context) {
    double percent = 0;

    if (income != null && expense != null && income! > 0 && expense! >= 0) {
      percent = (expense! / income!).clamp(0, 1);
    }

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.check, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percent * 100).toStringAsFixed(0)}% of your expenses, looks good.',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
