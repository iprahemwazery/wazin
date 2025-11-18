import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom/custom_text_feild.dart';
import 'package:wazin/features/auth/singUp/widget/sign_up_buttons.dart';

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  final TextEditingController name = TextEditingController();
  final TextEditingController emailc = TextEditingController();
  final TextEditingController phonec = TextEditingController();
  final TextEditingController dobc = TextEditingController();
  final TextEditingController pasc = TextEditingController();
  final TextEditingController conpasc = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    emailc.dispose();
    phonec.dispose();
    dobc.dispose();
    pasc.dispose();
    conpasc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Username'),
            CustomTextField(
              controller: name,
              isPassword: false,
              hintText: 'Enter your username',
            ),
            _buildLabel('Email'),
            CustomTextField(
              controller: emailc,
              isPassword: false,
              hintText: 'Enter your email',
            ),
            _buildLabel('Mobile Number'),
            CustomTextField(
              controller: phonec,
              isPassword: false,
              hintText: '+011 234 567 8901',
            ),
            _buildLabel('Date of Birth'),
            CustomTextField(
              controller: dobc,
              isPassword: false,
              hintText: 'DD/MM/YYYY',
            ),
            _buildLabel('Password'),
            CustomTextField(
              controller: pasc,
              isPassword: true,
              hintText: 'Password',
            ),
            _buildLabel('Confirm Password'),
            CustomTextField(
              controller: conpasc,
              isPassword: true,
              hintText: 'Confirm Password',
            ),
            const Gap(20),
            SignUpButtons(
              name: name,
              emailc: emailc,
              phonec: phonec,
              dobc: dobc,
              pasc: pasc,
              conpasc: conpasc,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        '  $text',
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
