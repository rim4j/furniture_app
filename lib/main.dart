import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/view/main_screen.dart';
import 'package:furniture_app/view/splash_screen.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: COLORS.grey,
    statusBarColor: COLORS.grey,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
