import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Categories/widget/balance_section.dart';
import 'package:wazin/features/Categories/widget/categories_grid.dart';
import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/home/widget/simple_check_box.dart';
import 'package:wazin/transaction_provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: CustomColors.green,
            body: Column(
              children: [
                const Gap(60),
                const AppBareNotification(title: 'Categories', showBack: true),
                const Gap(20),

                BalanceSection(
                  income: provider.totalIncome,
                  expense: provider.totalExpense,
                ),

                const Gap(8),
                GlobalProgressBar(),
                const Gap(8),

                SimpleCheckboxExample(
                  income: provider.totalIncome,
                  expense: provider.totalExpense,
                ),

                const Gap(20),

                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    padding: const EdgeInsets.all(28),
                    child: const SingleChildScrollView(child: CategoriesGrid()),
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
