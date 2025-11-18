import 'package:flutter/material.dart';

class FileProfileItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const FileProfileItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imagePath, width: 45, height: 45),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(fontSize: 21)),
        ],
      ),
    );
  }
}
