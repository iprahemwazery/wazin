import 'package:flutter/material.dart';
import 'package:wazin/features/Transactions/view/transaction_view.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryItem({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionView(category: title),
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.fill),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
