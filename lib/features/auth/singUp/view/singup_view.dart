// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gap/gap.dart';
// import 'package:wazin/Root.dart';
// import 'package:wazin/core/custom/custom_text_feild.dart';
// import 'package:wazin/core/custom_colors.dart';
// import 'package:wazin/features/auth/login/view/log_in_view.dart';
// import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';

// class SignUpView extends StatefulWidget {
//   const SignUpView({super.key});

//   @override
//   State<SignUpView> createState() => _SignUpViewState();
// }

// class _SignUpViewState extends State<SignUpView> {
//   final TextEditingController name = TextEditingController();
//   final TextEditingController emailc = TextEditingController();
//   final TextEditingController phonec = TextEditingController();
//   final TextEditingController dobc = TextEditingController();
//   final TextEditingController pasc = TextEditingController();
//   final TextEditingController conpasc = TextEditingController();

//   bool _isLoading = false;

//   @override
//   void dispose() {
//     name.dispose();
//     emailc.dispose();
//     phonec.dispose();
//     dobc.dispose();
//     pasc.dispose();
//     conpasc.dispose();
//     super.dispose();
//   }

//   void _showError(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
//     );
//   }

//   bool _validateInputs() {
//     final email = emailc.text.trim();
//     final pass = pasc.text;
//     final confirm = conpasc.text;

//     if (name.text.trim().isEmpty) {
//       _showError('من فضلك اكتب اسم المستخدم');
//       return false;
//     }

//     if (email.isEmpty) {
//       _showError('من فضلك ادخل الايميل');
//       return false;
//     }

//     final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//     if (!emailRegex.hasMatch(email)) {
//       _showError('صيغة الايميل غير صحيحة');
//       return false;
//     }

//     if (pass.isEmpty) {
//       _showError('من فضلك ادخل كلمة المرور');
//       return false;
//     }

//     if (pass.length < 6) {
//       _showError('كلمة المرور قصيرة جداً (أقل من 6 أحرف)');
//       return false;
//     }

//     if (confirm.isEmpty) {
//       _showError('من فضلك أكد كلمة المرور');
//       return false;
//     }

//     if (pass != confirm) {
//       _showError('كلمتا المرور غير متطابقتين');
//       return false;
//     }

//     return true;
//   }

//   Future<void> _signUp() async {
//     if (!_validateInputs()) return;

//     setState(() => _isLoading = true);

//     try {
//       // إنشاء حساب جديد في Firebase Auth
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: emailc.text.trim(),
//             password: pasc.text,
//           );

//       final user = credential.user;
//       if (user == null) throw FirebaseAuthException(code: 'user-not-found');

//       // تحديث اسم المستخدم بدون reload
//       await user.updateDisplayName(name.text.trim());

//       // الانتقال للصفحة الرئيسية مباشرة
//       if (!mounted) return;
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const Root()),
//         (route) => false,
//       );

//       // تخزين بيانات إضافية في Firestore بشكل غير متزامن
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .set({
//             'name': name.text.trim(),
//             'email': emailc.text.trim(),
//             'phone': phonec.text.trim(),
//             'dob': dobc.text.trim(),
//             'createdAt': FieldValue.serverTimestamp(),
//           })
//           .catchError((e) {
//             print('Firestore error: $e');
//           });
//     } on FirebaseAuthException catch (e) {
//       String msg = 'حدث خطأ أثناء إنشاء الحساب';
//       switch (e.code) {
//         case 'weak-password':
//           msg = 'كلمة المرور ضعيفة جداً. استخدم 6 أحرف على الأقل.';
//           break;
//         case 'email-already-in-use':
//           msg =
//               'هذا الايميل مستخدم بالفعل. حاول تسجيل الدخول أو استخدم ايميل آخر.';
//           break;
//         case 'invalid-email':
//           msg = 'صيغة الايميل غير صحيحة.';
//           break;
//         case 'network-request-failed':
//           msg = 'خطأ في الاتصال بالانترنت. تأكد من اتصالك وحاول مرة أخرى.';
//           break;
//         default:
//           msg = e.message ?? msg;
//       }
//       _showError(msg);
//     } catch (e) {
//       _showError('حصل خطأ غير متوقع: $e');
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: CustomColors.green,
//         body: Column(
//           children: [
//             const Gap(60),
//             const Center(
//               child: Text(
//                 'Create Account',
//                 style: TextStyle(
//                   fontSize: 26,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const Gap(40),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60),
//                     topRight: Radius.circular(60),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 28.0,
//                     vertical: 20,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel('Username'),
//                       CustomTextField(
//                         controller: name,
//                         isPassword: false,
//                         hintText: 'Enter your username',
//                       ),
//                       _buildLabel('Email'),
//                       CustomTextField(
//                         controller: emailc,
//                         isPassword: false,
//                         hintText: 'Enter your email',
//                       ),
//                       _buildLabel('Mobile Number'),
//                       CustomTextField(
//                         controller: phonec,
//                         isPassword: false,
//                         hintText: '+011 234 567 8901',
//                       ),
//                       _buildLabel('Date of Birth'),
//                       CustomTextField(
//                         controller: dobc,
//                         isPassword: false,
//                         hintText: 'DD/MM/YYYY',
//                       ),
//                       _buildLabel('Password'),
//                       CustomTextField(
//                         controller: pasc,
//                         isPassword: true,
//                         hintText: 'Password',
//                       ),
//                       _buildLabel('Confirm Password'),
//                       CustomTextField(
//                         controller: conpasc,
//                         isPassword: true,
//                         hintText: 'Confirm Password',
//                       ),
//                       const Gap(20),
//                       Center(
//                         child: Column(
//                           children: [
//                             CustomBottom(
//                               text: _isLoading ? 'Signing up...' : 'Sign Up',
//                               onPressed: _isLoading ? null : _signUp,
//                               color: CustomColors.green,
//                             ),
//                             const Gap(10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text('Already have an account? '),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const LogInView(),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Log In',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: CustomColors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (_isLoading) ...[
//                               const Gap(12),
//                               const CircularProgressIndicator(),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12, bottom: 6),
//       child: Text(
//         '  $text',
//         style: const TextStyle(fontSize: 16, color: Colors.black),
//       ),
//     );
//   }
// }
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
