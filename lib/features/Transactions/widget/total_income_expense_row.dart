import 'package:flutter/material.dart';
import 'package:wazin/features/Transactions/widget/balance_column_item.dart';

class TotalIncomeExpenseRow extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const TotalIncomeExpenseRow({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BalanceColumnItem(
          iconPath: 'assets/images/Income.png',
          label: 'Total Income',
          amount: totalIncome,
          color: Colors.white,
          alignEnd: true,
        ),
        const SizedBox(width: 20),
        Container(width: 2, height: 60, color: Colors.white),
        const SizedBox(width: 20),
        BalanceColumnItem(
          iconPath: 'assets/images/Expense.png',
          label: 'Total Expense',
          amount: totalExpense,
          color: Colors.blue,
          alignEnd: false,
        ),
      ],
    );
  }
}
