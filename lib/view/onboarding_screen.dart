import 'package:flutter/material.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/view/main_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  final RxBool onLastPage = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                onLastPage.value = (index == 2);
              },
              children: [
                Container(
                  color: COLORS.bg,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Get.width / 3),
                          child: Lottie.asset(
                            ANIMATIONS.onboarding1,
                            width: Get.width,
                            height: Get.height / 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Welcome to the furniture app",
                            textAlign: TextAlign.center,
                            style: fEncodeSansSemibold.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: COLORS.bg,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Get.width / 3),
                          child: Lottie.asset(
                            ANIMATIONS.onboarding2,
                            width: Get.width,
                            height: Get.height / 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Easy and fast ordering and immediate delivery of goods",
                            textAlign: TextAlign.center,
                            style: fEncodeSansSemibold.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: COLORS.bg,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.width / 3),
                        child: Lottie.asset(
                          ANIMATIONS.onboarding3,
                          width: Get.width,
                          height: Get.height / 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Buy quality products from us",
                          textAlign: TextAlign.center,
                          style: fEncodeSansSemibold.copyWith(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //indicators
            Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  SizedBox(
                    width: 35,
                    child: GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                        "Skip",
                        style: fEncodeSansMedium,
                      ),
                    ),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: COLORS.dark,
                      dotColor: COLORS.grey,
                    ),
                  ),

                  //next or done
                  SizedBox(
                    width: 35,
                    child: GestureDetector(
                      onTap: () {
                        if (!onLastPage.value) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        } else {
                          Get.off(() => MainScreen());
                        }
                      },
                      child: Text(
                        !onLastPage.value ? "Next" : "Done",
                        style: fEncodeSansMedium,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
