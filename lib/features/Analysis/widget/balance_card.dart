import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // النصوص على الشمال
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/Income.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 4),
                const Text('Total Balance', style: TextStyle(fontSize: 16)),
              ],
            ),
            const Text(
              r'$7,783.00',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Container(width: 2, height: 60, color: Colors.white),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/Expense.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 4),
                const Text('Total Expense', style: TextStyle(fontSize: 16)),
              ],
            ),
            const Text(
              r'-$1.187.40',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
