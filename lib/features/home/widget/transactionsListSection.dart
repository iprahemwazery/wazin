import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/features/home/widget/custom_salary.dart';
import 'package:wazin/features/home/widget/card_money_container.dart';

class TransactionsListSection extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionsListSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text("No transactions yet"));
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(28),
        children: [
          CarMoneyContainer(),
          const Gap(20),

          ...transactions.map((tx) {
            final date = parseTransactionDate(tx['date']);
            final amount = (tx['amount'] as num).toDouble();

            return TransactionItem(
              date: date,
              amount: amount,
              type: (tx['type'] as String?) ?? 'Income',
              label: (tx['label'] as String?) ?? '',
            );
          }).toList(),
        ],
      ),
    );
  }

  static DateTime parseTransactionDate(dynamic rawDate) {
    // لو بتستخدم cloud_firestore Timestamp
    try {
      if (rawDate == null) return DateTime.now();

      // Import Timestamp type only if cloud_firestore imported —
      // لكن هنا هنفحص بالاسم عشان ما نخربش إذا مش موجود
      final typeName = rawDate.runtimeType.toString();
      if (typeName.contains('Timestamp')) {
        // this assumes rawDate has toDate() method
        return (rawDate as dynamic).toDate() as DateTime;
      } else if (rawDate is String) {
        try {
          return DateTime.parse(rawDate);
        } catch (_) {
          return DateTime.now();
        }
      } else if (rawDate is DateTime) {
        return rawDate;
      } else {
        return DateTime.now();
      }
    } catch (_) {
      return DateTime.now();
    }
  }
}

class TransactionItem extends StatelessWidget {
  final DateTime date;
  final double amount;
  final String type;
  final String label;

  const TransactionItem({
    super.key,
    required this.date,
    required this.amount,
    required this.type,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}';

    return Column(
      children: [
        CustomSalary(
          salaryTime: time,
          salaryAmount:
              amount >= 0
                  ? '+\$${amount.toStringAsFixed(2)}'
                  : '-\$${amount.abs().toStringAsFixed(2)}',
          salaryDate: type,
          salaryLabel: label,
          salaryIconPath:
              type == 'Income'
                  ? 'assets/images/Saving Funtional(1).png'
                  : 'assets/images/Icon Salary.png',
        ),
        const Gap(20),
      ],
    );
  }
}
