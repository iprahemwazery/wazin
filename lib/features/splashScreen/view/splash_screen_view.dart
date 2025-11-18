import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazin/Root.dart';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/auth/login/view/log_in_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _logoOpacityAnimation;

  late AnimationController _bgController;
  late Animation<Color?> _bgAnimation;

  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();

    // ⭐ LOGO ANIMATION (Scale + Rotate + Fade)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300), // مدة أطول وأجمل
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.3, // تكبير الصورة بشكل جذاب
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut, // البوم
      ),
    );

    _logoRotateAnimation = Tween<double>(
      begin: -0.6, // دوران أكبر
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // ⭐ ANIMATED BACKGROUND GRADIENT
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bgAnimation = ColorTween(
      begin: const Color(0xFF1E88E5),
      end: CustomColors.green,
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));

    // START
    _logoController.forward();

    // CHECK LOGIN
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn = status;

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn! ? const Root() : const LogInView(),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgAnimation,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _bgAnimation.value!,
                  _bgAnimation.value!.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoOpacityAnimation.value,
                    child: Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: Transform.rotate(
                        angle: _logoRotateAnimation.value,
                        child: SvgPicture.asset(
                          'assets/images/svg_navbar/splah_screen.svg',
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
