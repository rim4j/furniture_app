import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/furniture_divider.dart';
import 'package:furniture_app/components/profile_item.dart';
import 'package:furniture_app/components/round_button.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:furniture_app/view/login_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/images.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref("User");

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
      body: StreamBuilder(
        stream: ref.child(SessionController().userId.toString()).onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
            return Column(
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
                        imageUrl: map["profile"] == ""
                            ? "https://t4.ftcdn.net/jpg/04/70/29/97/240_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                            : map["profile"],
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                            map["profile"] == ""
                                ? "https://t4.ftcdn.net/jpg/04/70/29/97/240_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                                : map["profile"].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ProfileItem(
                      title: "username",
                      value: map["userName"],
                      icon: const Icon(Icons.person),
                    ),
                    furnitureDivider(),
                    ProfileItem(
                      title: "email",
                      value: map["email"],
                      icon: const Icon(Icons.email),
                    ),
                    furnitureDivider(),
                    ProfileItem(
                      title: "user id",
                      value: map["uid"],
                      icon: const Icon(Icons.abc_outlined),
                    ),
                    furnitureDivider(),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundButton(
                        color: Colors.red,
                        title: "Log out",
                        onPress: () => logout(),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
                child: Text(
              "somethings went wrong",
              style: fEncodeSansBold.copyWith(fontSize: largeFontSize),
            ));
          }
        },
      ),
    );
  }
}
