import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/view/account_screen.dart';
import 'package:furniture_app/view/cart_screen.dart';
import 'package:furniture_app/view/favorites_screen.dart';
import 'package:furniture_app/view/home_screen.dart';
import 'package:furniture_app/view/splash_screen.dart';
import 'package:get/get.dart';

import '../config/app_styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt currentScreenIndex = RxInt(0);

    return Scaffold(
      backgroundColor: COLORS.bg,
      //bottom navigation
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: Get.height / 12,
        child: Obx(
          () => CustomNavigationBar(
            isFloating: true,
            borderRadius: const Radius.circular(40),
            unSelectedColor: COLORS.grey,
            selectedColor: COLORS.lightGrey,
            backgroundColor: COLORS.dark,
            strokeColor: Colors.transparent,
            scaleFactor: 0.1,
            iconSize: 40,
            currentIndex: currentScreenIndex.value,
            onTap: (index) {
              currentScreenIndex.value = index;
            },
            items: [
              CustomNavigationBarItem(
                icon: currentScreenIndex.value == 0
                    ? SvgPicture.asset(ICONS.homeSelected)
                    : SvgPicture.asset(ICONS.homeUnselected),
              ),
              CustomNavigationBarItem(
                icon: currentScreenIndex.value == 1
                    ? SvgPicture.asset(ICONS.cartSelected)
                    : SvgPicture.asset(ICONS.cartUnselected),
              ),
              CustomNavigationBarItem(
                icon: currentScreenIndex.value == 2
                    ? SvgPicture.asset(ICONS.favoriteSelected)
                    : SvgPicture.asset(ICONS.favoriteUnselected),
              ),
              CustomNavigationBarItem(
                icon: currentScreenIndex.value == 3
                    ? SvgPicture.asset(ICONS.accountSelected)
                    : SvgPicture.asset(ICONS.accountUnselected),
              ),
            ],
          ),
        ),
      ),
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
