import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/auth/singUp/widget/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColors.green,
        body: Column(
          children: const [
            Gap(60),
            Center(
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(40),
            Expanded(child: SignUpFormSection()),
          ],
        ),
      ),
    );
  }
}
