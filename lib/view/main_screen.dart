import 'package:flutter/material.dart';
import 'package:furniture_app/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:furniture_app/view/account_screen.dart';
import 'package:furniture_app/view/cart_screen.dart';
import 'package:furniture_app/view/favorites_screen.dart';
import 'package:furniture_app/view/home_screen.dart';

import '../components/bottom_nav.dart';
import '../config/app_styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt currentScreenIndex = RxInt(0);
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: COLORS.bg,
      //bottom navigation
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          bottomNav(currentScreenIndex, cartController.totalAmount),
      body: Obx(
        () => IndexedStack(
          index: currentScreenIndex.value,
          children: [
            HomeScreen(),
            CartScreen(),
            FavoritesScreen(),
            AccountScreen()
          ],
        ),
      ),
    );
  }
}
