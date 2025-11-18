import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Transactions/widget/add_transaction_dialog.dart';
import 'package:wazin/features/Transactions/widget/total_balance_card.dart';
import 'package:wazin/features/Transactions/widget/total_income_expense_row.dart';
import 'package:wazin/features/Transactions/widget/transactions_list.dart';
import 'package:wazin/features/Transactions/widget/custom_porgress_bar_over_lay.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/home/widget/simple_check_box.dart';
import 'package:wazin/transaction_provider.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AddTransactionDialog());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionProvider>();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.transactionsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final transactions = snapshot.data ?? [];
        final totalIncome = transactions
            .where((tx) => (tx['amount'] as num) >= 0)
            .fold(0.0, (sum, tx) => sum + (tx['amount'] as num).toDouble());
        final totalExpense = transactions
            .where((tx) => (tx['amount'] as num) < 0)
            .fold(0.0, (sum, tx) => sum + -(tx['amount'] as num).toDouble());
        final totalBalance = totalIncome - totalExpense;

        return Scaffold(
          backgroundColor: CustomColors.green,
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomColors.green,
            child: const Icon(Icons.add),
            onPressed: () => _showAddTransactionDialog(context),
          ),
          body: Column(
            children: [
              const Gap(60),
              const AppBareNotification(title: 'Transactions', showBack: true),
              const Gap(20),
              TotalBalanceCard(totalBalance: totalBalance),
              const Gap(20),
              TotalIncomeExpenseRow(
                totalIncome: totalIncome,
                totalExpense: totalExpense,
              ),
              const Gap(8),
              const GlobalProgressBar(),
              const Gap(8),
              SimpleCheckboxExample(income: totalIncome, expense: totalExpense),
              const Gap(20),
              Expanded(child: TransactionsList(transactions: transactions)),
            ],
          ),
        );
      },
    );
  }
}
