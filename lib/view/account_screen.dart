import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/furniture_divider.dart';
import 'package:furniture_app/components/input_text.dart';
import 'package:furniture_app/components/profile_item.dart';
import 'package:furniture_app/components/round_button.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/controller/profile_controller.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:furniture_app/view/login_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../constants/images.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref("User");

  ProfileController profileController = Get.put(ProfileController());

  void logout() {
    auth.signOut().then((value) {
      SessionController().userId = "";
      Get.off(() => const LoginScreen());
      Get.snackbar("success", "user logged out successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    void updateUserNameProfileBottomSheet(String username) async {
      profileController.usernameController.text = username;
      await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 20,
          avoidStatusBar: true,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: COLORS.grey,
                    borderRadius: BorderRadius.circular(500),
                  ),
                ),
              ),
            ],
          ),
          builder: (context, state) {
            return SizedBox(
              width: Get.width,
              child: Material(
                color: COLORS.bg,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                        key: profileController.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputText(
                              controller: profileController.usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter username";
                                } else if (value.length < 4) {
                                  return "At least 4 characters";
                                } else if (value.length > 13) {
                                  return "Maximum characters is 13";
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.emailAddress,
                              hint: "username",
                              prefixIcon:
                                  const Icon(Icons.person, color: COLORS.grey),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        "cancel",
                                        style: fEncodeSansMedium.copyWith(
                                            fontSize: smallFontSize),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        backgroundColor: COLORS.dark,
                                      ),
                                      onPressed: () {
                                        if (profileController
                                            .formKey.currentState!
                                            .validate()) {
                                          //update user name in firebase
                                          profileController.updateUserName();

                                          Get.back();
                                        }
                                      },
                                      child: Text(
                                        "ok",
                                        style: fEncodeSansMedium.copyWith(
                                            fontSize: smallFontSize),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
    }

    void updateProfileImage() async {
      await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 20,
          avoidStatusBar: true,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.8, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: COLORS.grey,
                    borderRadius: BorderRadius.circular(500),
                  ),
                ),
              ),
            ],
          ),
          builder: (context, state) {
            return SizedBox(
              width: Get.width,
              child: Material(
                color: COLORS.bg,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    InkWell(
                      onTap: () {
                        print('pick camera picture');
                        profileController.pickCameraImage();

                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.camera,
                              color: COLORS.dark,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Camera",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: smallFontSize,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('pick gallery picture');
                        profileController.pickGalleryImage();

                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              color: COLORS.dark,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Gallery",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: smallFontSize,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
    }

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
                          updateProfileImage();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: COLORS.bg,
                        ),
                      ),
                    ),
                    Obx(
                      () => Positioned(
                        bottom: 10,
                        left: Get.width / 15,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: COLORS.grey, width: 3),
                          ),
                          width: 100,
                          height: 100,
                          child: profileController.loading.value
                              ? const CircularProgressIndicator(
                                  color: COLORS.dark,
                                )
                              : ClipRRect(
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
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ProfileItem(
                      onTap: () {
                        updateUserNameProfileBottomSheet(map["userName"]);
                      },
                      title: "username",
                      value: map["userName"],
                      icon: const Icon(Icons.person),
                    ),
                    furnitureDivider(),
                    ProfileItem(
                      onTap: () {},
                      title: "email",
                      value: map["email"],
                      icon: const Icon(Icons.email),
                    ),
                    furnitureDivider(),
                    ProfileItem(
                      onTap: () {},
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
                    ),
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
