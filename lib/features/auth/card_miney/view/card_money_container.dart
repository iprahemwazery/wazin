import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/auth/card_miney/widget/circle_progress_section.dart';
import 'package:wazin/features/auth/card_miney/widget/vertical_divider_widget.dart';
import 'package:wazin/features/auth/card_miney/widget/weekly_current_section.dart';
import 'package:wazin/features/auth/card_miney/widget/weekly_data_calculator.dart';
import 'package:wazin/features/auth/card_miney/widget/weekly_last_section.dart';
import 'package:wazin/features/dataCardHome/view/data_cart_view.dart';
import 'package:wazin/transaction_provider.dart';

class CarMoneyContainer extends StatelessWidget {
  const CarMoneyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.transactionsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final weeklyData = WeeklyDataCalculator.calculate(snapshot.data!);

        double progress =
            weeklyData.currentWeekIncome == 0
                ? 0
                : weeklyData.currentWeekRemaining /
                    weeklyData.currentWeekIncome;

        if (progress < 0) progress = 0;

        final circleLabel =
            weeklyData.currentWeekRemaining >= 0 ? 'Income' : 'Expense';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DataCartView()),
            );
          },
          child: Container(
            height: 180,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: CustomColors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                CircleProgressSection(
                  progress: progress,
                  circleLabel: circleLabel,
                  remaining: weeklyData.currentWeekRemaining,
                ),

                const VerticalDividerWidget(),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeeklyLastSection(weeklyData: weeklyData),
                      WeeklyCurrentSection(weeklyData: weeklyData),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
