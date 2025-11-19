import 'package:flutter/material.dart';

class WeeklyHeader extends StatelessWidget {
  final DateTime selectedMonth;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const WeeklyHeader({
    super.key,
    required this.selectedMonth,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth =
        selectedMonth.month == DateTime.now().month &&
        selectedMonth.year == DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: onPrev,
          ),
          const Spacer(),
          Text(
            "${selectedMonth.month}/${selectedMonth.year}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: isCurrentMonth ? Colors.grey : Colors.black,
            ),
            onPressed: isCurrentMonth ? null : onNext,
          ),
        ],
      ),
    );
  }
}
