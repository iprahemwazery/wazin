import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoriresList extends StatelessWidget {
  const CategoriresList({
    super.key,
    required this.title,
    required this.imagePath,
  });
  final String title;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.fill),
        Gap(10),
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
