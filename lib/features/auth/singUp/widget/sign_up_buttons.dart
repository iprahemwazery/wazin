import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';
import 'package:wazin/features/auth/login/view/log_in_view.dart';
import 'package:wazin/Root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpButtons extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController emailc;
  final TextEditingController phonec;
  final TextEditingController dobc;
  final TextEditingController pasc;
  final TextEditingController conpasc;

  const SignUpButtons({
    super.key,
    required this.name,
    required this.emailc,
    required this.phonec,
    required this.dobc,
    required this.pasc,
    required this.conpasc,
  });

  @override
  State<SignUpButtons> createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  bool _isLoading = false;

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  bool _validateInputs() {
    final email = widget.emailc.text.trim();
    final pass = widget.pasc.text;
    final confirm = widget.conpasc.text;

    if (widget.name.text.trim().isEmpty) {
      _showError('من فضلك اكتب اسم المستخدم');
      return false;
    }
    if (email.isEmpty) {
      _showError('من فضلك ادخل الايميل');
      return false;
    }
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      _showError('صيغة الايميل غير صحيحة');
      return false;
    }
    if (pass.isEmpty) {
      _showError('من فضلك ادخل كلمة المرور');
      return false;
    }
    if (pass.length < 6) {
      _showError('كلمة المرور قصيرة جداً (أقل من 6 أحرف)');
      return false;
    }
    if (confirm.isEmpty) {
      _showError('من فضلك أكد كلمة المرور');
      return false;
    }
    if (pass != confirm) {
      _showError('كلمتا المرور غير متطابقتين');
      return false;
    }
    return true;
  }

  Future<void> _signUp() async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: widget.emailc.text.trim(),
            password: widget.pasc.text,
          );

      final user = credential.user;
      if (user == null) throw FirebaseAuthException(code: 'user-not-found');

      await user.updateDisplayName(widget.name.text.trim());

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Root()),
        (route) => false,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            'name': widget.name.text.trim(),
            'email': widget.emailc.text.trim(),
            'phone': widget.phonec.text.trim(),
            'dob': widget.dobc.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          })
          .catchError((e) => print('Firestore error: $e'));
    } on FirebaseAuthException catch (e) {
      String msg = 'حدث خطأ أثناء إنشاء الحساب';
      switch (e.code) {
        case 'weak-password':
          msg = 'كلمة المرور ضعيفة جداً. استخدم 6 أحرف على الأقل.';
          break;
        case 'email-already-in-use':
          msg = 'هذا الايميل مستخدم بالفعل.';
          break;
        case 'invalid-email':
          msg = 'صيغة الايميل غير صحيحة.';
          break;
        case 'network-request-failed':
          msg = 'خطأ في الاتصال بالانترنت.';
          break;
        default:
          msg = e.message ?? msg;
      }
      _showError(msg);
    } catch (e) {
      _showError('حصل خطأ غير متوقع: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomBottom(
            text: _isLoading ? 'Signing up...' : 'Sign Up',
            onPressed: _isLoading ? null : _signUp,
            color: CustomColors.green,
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account? '),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInView()),
                  );
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20,
                    color: CustomColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading) ...[const Gap(12), const CircularProgressIndicator()],
        ],
      ),
    );
  }
}
