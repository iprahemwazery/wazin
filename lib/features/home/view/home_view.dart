import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
import 'package:wazin/features/home/widget/BalanceRowSection.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/home/widget/simple_check_box.dart';
import 'package:wazin/features/home/widget/transactionsListSection.dart';
import 'package:wazin/transaction_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.green,
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: provider.transactionsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }

            final transactions = snapshot.data ?? [];

            return Column(
              children: [
                const Gap(60),
                const AppBareNotification(title: 'Hi, Welcome Back'),
                const Gap(20),

                BalanceRowSection(
                  income: provider.totalIncome,
                  expense: provider.totalExpense,
                ),

                const Gap(20),
                const GlobalProgressBar(),
                const Gap(8),

                SimpleCheckboxExample(
                  income: provider.totalIncome,
                  expense: provider.totalExpense,
                ),

                const Gap(20),

                Expanded(
                  child: TransactionsListSection(transactions: transactions),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
