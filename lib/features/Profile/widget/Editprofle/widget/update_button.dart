import 'package:flutter/material.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';

class UpdateButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UpdateButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomBottom(
      text: text,
      onPressed: onPressed,
      color: CustomColors.green,
    );
  }
}
