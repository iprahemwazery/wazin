import 'package:flutter/material.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 2,
      height: 140,
      color: Colors.white,
    );
  }
}
