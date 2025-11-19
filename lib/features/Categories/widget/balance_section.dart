import 'package:flutter/material.dart';
import 'balance_item.dart';

class BalanceSection extends StatelessWidget {
  final double income;
  final double expense;

  const BalanceSection({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BalanceItem(
          iconPath: 'assets/images/Income.png',
          label: 'Total Balance',
          amount: income,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Container(width: 2, height: 60, color: Colors.white),
        const SizedBox(width: 20),
        BalanceItem(
          iconPath: 'assets/images/Expense.png',
          label: 'Total Expense',
          amount: expense,
          color: Colors.blue,
        ),
      ],
    );
  }
}
