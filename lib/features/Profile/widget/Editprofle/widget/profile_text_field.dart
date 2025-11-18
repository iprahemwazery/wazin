import 'package:flutter/material.dart';
import 'package:wazin/core/custom/custom_text_feild.dart';
import 'package:gap/gap.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const ProfileTextField({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        CustomTextField(
          controller: controller,
          hintText: 'Enter your $title',
          isPassword: false,
        ),
      ],
    );
  }
}
