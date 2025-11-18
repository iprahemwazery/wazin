import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FileProfile extends StatelessWidget {
  const FileProfile({
    super.key,
    required this.imagePath,
    required this.title,
    this.onTap,
  });
  final String imagePath;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.fill),
          const Gap(15),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
