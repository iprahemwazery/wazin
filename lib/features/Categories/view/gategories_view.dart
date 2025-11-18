import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Categories/widget/categorires_list.dart';
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
        final totalIncome = provider.totalIncome;
        final totalExpense = provider.totalExpense;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: CustomColors.green,
            body: Column(
              children: [
                const Gap(60),
                AppBareNotification(title: 'Categories', showBack: true),
                const Gap(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBalanceColumn(
                      iconPath: 'assets/images/Income.png',
                      label: 'Total Balance',
                      amount: provider.totalIncome,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    Container(width: 2, height: 60, color: Colors.white),
                    const SizedBox(width: 20),
                    _buildBalanceColumn(
                      iconPath: 'assets/images/Expense.png',
                      label: 'Total Expense',
                      amount: provider.totalExpense,
                      color: Colors.blue,
                    ),
                  ],
                ),

                const Gap(8),
                GlobalProgressBar(),
                const Gap(8),
                SimpleCheckboxExample(
                  income: totalIncome,
                  expense: totalExpense,
                ),
                const Gap(20),

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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CategoriresList(
                                title: 'Food',
                                imagePath: 'assets/images/Icon Food.png',
                              ),
                              CategoriresList(
                                title: 'Transport',
                                imagePath: 'assets/images/Icon transport.png',
                              ),
                              CategoriresList(
                                title: 'Medicine',
                                imagePath:
                                    'assets/images/Medicine Funtional.png',
                              ),
                            ],
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CategoriresList(
                                title: 'Groceries',
                                imagePath: 'assets/images/Icon Groceries.png',
                              ),
                              CategoriresList(
                                title: 'Rent',
                                imagePath: 'assets/images/Icon Rent.png',
                              ),
                              CategoriresList(
                                title: 'Gifts',
                                imagePath: 'assets/images/Gift Funtional.png',
                              ),
                            ],
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CategoriresList(
                                title: 'Savings',
                                imagePath:
                                    'assets/images/Saving Funtional(1).png',
                              ),
                              CategoriresList(
                                title: 'FUN',
                                imagePath:
                                    'assets/images/Entertainment Funtional.png',
                              ),
                              CategoriresList(
                                title: 'More',
                                imagePath: 'assets/images/More Funtional.png',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

Widget _buildBalanceColumn({
  required String iconPath,
  required String label,
  required double amount,
  required Color color,
}) {
  return Column(
    crossAxisAlignment:
        color == Colors.white
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Image.asset(iconPath, width: 20, height: 20, fit: BoxFit.fill),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
      Text(
        '\$${amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
