import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/dataCardHome/widget/week_crach.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';
import 'package:wazin/features/auth/card_miney/view/card_money_container.dart';
import 'package:wazin/features/home/widget/custom_salary.dart';
import 'package:wazin/transaction_provider.dart';

class DataCartView extends StatelessWidget {
  const DataCartView({super.key});

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
            AppBareNotification(title: 'Quickly Analysis', showBack: true),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: CarMoneyContainer(),
            ),
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
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream:
                      context.read<TransactionProvider>().transactionsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("حدث خطأ: ${snapshot.error}"));
                    }

                    final transactions = snapshot.data ?? [];

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 250, child: WeeklyBarChart()),
                          const Gap(20),

                          ...transactions.map((tx) {
                            final date =
                                tx['date'] is Timestamp
                                    ? (tx['date'] as Timestamp).toDate()
                                    : DateTime.tryParse(
                                          tx['date'].toString(),
                                        ) ??
                                        DateTime.now();

                            final amount = (tx['amount'] as num).toDouble();
                            final type = tx['type'] ?? "Unknown";
                            final label = tx['label'] ?? "";

                            return Column(
                              children: [
                                CustomSalary(
                                  salaryTime:
                                      "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}",
                                  salaryAmount:
                                      amount >= 0
                                          ? "+\$${amount.toStringAsFixed(2)}"
                                          : "-\$${amount.abs().toStringAsFixed(2)}",
                                  salaryDate: type,
                                  salaryLabel: label,
                                  salaryIconPath:
                                      amount >= 0
                                          ? "assets/images/Saving Funtional(1).png"
                                          : "assets/images/Icon Salary.png",
                                ),
                                const Gap(20),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
