import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/features/auth/card_miney/widget/weekly_data_calculator.dart';

class WeeklyLastSection extends StatelessWidget {
  final WeeklyData weeklyData;

  const WeeklyLastSection({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Vectormany.png', width: 25, height: 25),
            const Gap(8),
            const Text(
              'Last Week',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const Gap(8),
        Text(
          weeklyData.lastWeekIncome == 0
              ? 'No data'
              : '\$${weeklyData.lastWeekRemaining.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 144,
          height: 2,
          color: Colors.white,
        ),
      ],
    );
  }
}
