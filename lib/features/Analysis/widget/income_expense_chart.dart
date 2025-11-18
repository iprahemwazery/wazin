import 'package:flutter/material.dart';
import 'package:wazin/features/dataCardHome/widget/week_crach.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';

class IncomeExpenseChart extends StatelessWidget {
  const IncomeExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 250, child: WeeklyBarChart()),
        const Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/Income.png',
              width: 20,
              height: 20,
              color: CustomColors.green,
            ),
            Image.asset(
              'assets/images/Expense.png',
              width: 20,
              height: 20,
              color: CustomColors.blue,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              'Income',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Expense',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              r'$4,783.00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomColors.green,
              ),
            ),
            Text(
              r'$1.187.40',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomColors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
