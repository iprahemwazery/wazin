import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoryItem(
              title: 'Food',
              imagePath: 'assets/images/Icon Food.png',
            ),
            CategoryItem(
              title: 'Transport',
              imagePath: 'assets/images/Icon transport.png',
            ),
            CategoryItem(
              title: 'Medicine',
              imagePath: 'assets/images/Medicine Funtional.png',
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoryItem(
              title: 'Groceries',
              imagePath: 'assets/images/Icon Groceries.png',
            ),
            CategoryItem(
              title: 'Rent',
              imagePath: 'assets/images/Icon Rent.png',
            ),
            CategoryItem(
              title: 'Gifts',
              imagePath: 'assets/images/Gift Funtional.png',
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CategoryItem(
              title: 'Savings',
              imagePath: 'assets/images/Saving Funtional(1).png',
            ),
            CategoryItem(
              title: 'FUN',
              imagePath: 'assets/images/Entertainment Funtional.png',
            ),
            CategoryItem(
              title: 'More',
              imagePath: 'assets/images/More Funtional.png',
            ),
          ],
        ),
      ],
    );
  }
}
