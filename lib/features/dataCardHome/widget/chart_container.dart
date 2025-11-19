import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Widget child;

  const ChartContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: 340,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 247, 240),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
