import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Analysis/widget/balance_card.dart';
import 'package:wazin/features/Analysis/widget/income_expense_chart.dart';
import 'package:wazin/features/Analysis/widget/my_targets.dart';
import 'package:wazin/features/Analysis/widget/checkboxes_section.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
import 'package:wazin/features/home/widget/slied_day.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.green,
        body: Column(
          children: [
            const Gap(60),
            const AppBareNotification(title: 'Analysis', showBack: true),
            const Gap(20),

            // Total Balance & Expense
            const BalanceCard(),
            const GlobalProgressBar(),
            const Gap(8),
            const CheckboxesSection(),
            const Gap(20),

            // Chart & My Targets
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SlideDay(),
                      SizedBox(height: 20),
                      IncomeExpenseChart(),
                      SizedBox(height: 25),
                      MyTargets(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
