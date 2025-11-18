import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/Vector_light.png'),
              width: 120,
              height: 125,
              fit: BoxFit.cover,
            ),
            const Gap(2),
            const Text(
              'FinWise',
              style: TextStyle(
                fontSize: 52,
                color: CustomColors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ),
            const Gap(20),
            // دي اللي كانت فيها المشكلة 👇
            CustomBottom(text: 'Login', color: CustomColors.green),
            const Gap(20),
            CustomBottom(text: 'Sign Up'),
            const Gap(10),
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
