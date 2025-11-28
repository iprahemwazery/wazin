import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wazin/features/auth/login/cubit/login_cubit.dart';
import 'package:wazin/features/auth/login/cubit/login_state.dart';
import 'package:wazin/Root.dart';
import 'package:wazin/features/auth/singUp/view/singup_view.dart';
import 'package:wazin/features/splashScreen/widget/custom_bottom.dart';
import 'package:wazin/core/custom_colors.dart';

class LoginButtons extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButtons({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Root()),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              CustomBottom(
                text: state is LoginLoading ? "Loading..." : "Log In",
                onPressed:
                    state is LoginLoading
                        ? null
                        : () {
                          context.read<LoginCubit>().login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                color: CustomColors.green,
              ),
              Gap(16),
              CustomBottom(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpView()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
