import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/auth/card_miney/widget/weekly_data_calculator.dart';

class WeeklyCurrentSection extends StatelessWidget {
  final WeeklyData weeklyData;

  const WeeklyCurrentSection({super.key, required this.weeklyData});

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
              'This Week',
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
          '\$${weeklyData.currentWeekRemaining.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: CustomColors.blue,
          ),
        ),
      ],
    );
  }
}
