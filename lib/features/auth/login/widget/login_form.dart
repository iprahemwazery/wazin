import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom/custom_text_feild.dart';
import 'package:wazin/features/auth/login/widget/login_buttons.dart';
import 'package:wazin/features/auth/login/widget/forgot_password.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '  Username or email',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const Gap(8),
            CustomTextField(
              controller: _emailController,
              isPassword: false,
              hintText: 'Enter your username or email',
            ),
            const Gap(25),
            const Text(
              '  Password',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            CustomTextField(
              controller: _passwordController,
              isPassword: true,
              hintText: 'Password',
            ),
            const Gap(35),
            ForgotPasswordText(),
            const Gap(8),
            LoginButtons(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
