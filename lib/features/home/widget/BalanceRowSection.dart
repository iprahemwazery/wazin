import 'package:flutter/material.dart';
import 'package:wazin/features/home/widget/_buildBalanceColumn.dart';

class BalanceRowSection extends StatelessWidget {
  final double income;
  final double expense;

  const BalanceRowSection({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BalanceColumnItem(
          iconPath: 'assets/images/Income.png',
          label: 'Total Balance',
          amount: income,
          color: Colors.white,
          alignEnd: true,
        ),
        const SizedBox(width: 20),
        Container(width: 2, height: 60, color: Colors.white),
        const SizedBox(width: 20),
        BalanceColumnItem(
          iconPath: 'assets/images/Expense.png',
          label: 'Total Expense',
          amount: expense,
          color: Colors.blue,
          alignEnd: false,
        ),
      ],
    );
  }
}
