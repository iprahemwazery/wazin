import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wazin/features/home/widget/custom_salary.dart';
import 'package:wazin/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionItem({super.key, required this.transaction});

  DateTime parseTransactionDate(dynamic rawDate) {
    if (rawDate is Timestamp) return rawDate.toDate();
    if (rawDate is String) {
      try {
        return DateTime.parse(rawDate);
      } catch (_) {
        return DateTime.now();
      }
    }
    if (rawDate is DateTime) return rawDate;
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    final date = parseTransactionDate(transaction['date']);
    final amount = (transaction['amount'] as num).toDouble();
    final type = transaction['type'] as String? ?? 'Income';
    final label = transaction['label'] as String? ?? '';
    final id = transaction['id'] as String;

    final time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} - ${date.day}/${date.month}';

    return Column(
      children: [
        GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder:
                  (ctx) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: const Text(
                      'هل أنت متأكد أنك تريد حذف هذه المعاملة؟',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                          await provider.deleteTransaction(id);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
            );
          },
          child: CustomSalary(
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
        ),
        const Gap(20),
      ],
    );
  }
}
