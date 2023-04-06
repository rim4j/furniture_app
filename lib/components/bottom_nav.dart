import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/controller/cart_controller.dart';
import 'package:get/get.dart';

import '../config/app_styles.dart';
import '../constants/images.dart';

Widget bottomNav(RxInt currentScreenIndex, RxInt totalAmount) {
  return Container(
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
            badgeCount: totalAmount.value,
            showBadge: totalAmount.value == 0 ? false : true,
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
  );
}
