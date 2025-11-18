import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/features/home/widget/custom_salary.dart';

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
