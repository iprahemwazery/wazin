import 'package:flutter/material.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';
import 'package:wazin/features/auth/singUp/view/singup_view.dart';
import 'package:wazin/Root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginButtons extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButtons({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError(context, "من فضلك ادخل الإيميل والباسورد ❌");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveLoginStatus();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Root()),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          _showError(context, "الإيميل غير مسجّل ❌");
          break;
        case 'wrong-password':
          _showError(context, "الباسورد غلط ❌");
          break;
        case 'invalid-email':
          _showError(context, "صيغة الإيميل غير صحيحة ❌");
          break;
        case 'network-request-failed':
          _showError(context, "مشكلة في الاتصال بالإنترنت 📶");
          break;
        default:
          _showError(context, "خطأ: ${e.message}");
      }
    } catch (e) {
      _showError(context, "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBottom(
          text: 'Log In',
          onPressed: () => _login(context),
          color: CustomColors.green,
        ),
        const SizedBox(height: 6),
        CustomBottom(
          text: 'Sign Up',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpView()),
            );
          },
        ),
        const SizedBox(height: 10),
        const Text('Or connect with'),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Facebook.png', width: 45, height: 45),
            const SizedBox(width: 20),
            Image.asset('assets/images/Google.png', width: 45, height: 45),
          ],
        ),
      ],
    );
  }
}
