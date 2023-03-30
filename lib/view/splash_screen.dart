import 'package:flutter/material.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/view/onboarding_screen.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      //!navigation
      Get.off(() => OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Lottie.asset(
              ANIMATIONS.splash,
              repeat: false,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Image.asset(
              IMAGES.logo,
              scale: 2,
            ),
          ),
          SizedBox(
            height: 100,
            child: Lottie.asset(
              ANIMATIONS.loading,
            ),
          ),
        ],
      ),
    );
  }
}
