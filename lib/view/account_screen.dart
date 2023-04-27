import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/furniture_divider.dart';
import 'package:furniture_app/components/round_button.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:furniture_app/view/login_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/images.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  void logout() {
    auth.signOut().then((value) {
      SessionController().userId = "";
      Get.off(() => const LoginScreen());
      Get.snackbar("success", "user logged out successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height / 3,
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: GradientColors.backgroundProfile,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://xsgames.co/randomusers/assets/avatars/male/74.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Lottie.asset(ANIMATIONS.loading),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 10,
                right: Get.width / 15,
                child: IconButton(
                  onPressed: () {
                    print("selected image profile");
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: COLORS.bg,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: Get.width / 15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: COLORS.grey, width: 3),
                  ),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://xsgames.co/randomusers/assets/avatars/male/74.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "username",
                  style: fEncodeSansBold.copyWith(
                    fontSize: mediumFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "amir hossein",
                  style: fEncodeSansMedium.copyWith(
                    fontSize: smallFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                furnitureDivider(),
                const SizedBox(height: 20),
                Text(
                  "email",
                  style: fEncodeSansBold.copyWith(
                    fontSize: mediumFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "amirhosseinjalali818@gmail.com",
                  style: fEncodeSansMedium.copyWith(
                    fontSize: smallFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                furnitureDivider(),
                const SizedBox(height: 20),
                Text(
                  "user id",
                  style: fEncodeSansBold.copyWith(
                    fontSize: mediumFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  SessionController().userId.toString(),
                  style: fEncodeSansMedium.copyWith(
                    fontSize: smallFontSize,
                  ),
                ),
                const SizedBox(height: 10),
                furnitureDivider(),
                const SizedBox(height: 40),
                RoundButton(
                  color: Colors.red,
                  title: "Log out",
                  onPress: () => logout(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
