import 'package:flutter/material.dart';
import 'package:wazin/features/Categories/widget/categorires_list.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryItem({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CategoriresList(title: title, imagePath: imagePath);
  }
}
