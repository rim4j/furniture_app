import 'package:flutter/material.dart';
import 'package:furniture_app/view/home_screen.dart';
import 'package:furniture_app/view/splash_screen.dart';

import '../config/app_styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: HomeScreen(),
    );
  }
}
