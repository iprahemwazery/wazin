import 'package:flutter/material.dart';

class BalanceColumnItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final double amount;
  final Color color;
  final bool alignEnd;

  const BalanceColumnItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.amount,
    required this.color,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(iconPath, width: 20, height: 20),
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
}
