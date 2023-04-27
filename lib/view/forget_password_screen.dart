import 'package:flutter/material.dart';
import 'package:furniture_app/controller/auth/forget_password_controller.dart';
import 'package:get/get.dart';

import '../components/input_text.dart';
import '../components/round_button.dart';
import '../config/app_styles.dart';
import '../constants/images.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());

  TextEditingController gmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: COLORS.dark),
        title: Text(
          "Forget password",
          style: fEncodeSansBold.copyWith(
            color: COLORS.dark,
            fontSize: largeFontSize,
          ),
        ),
        backgroundColor: COLORS.bg,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                IMAGES.logo,
                width: Get.width / 2,
                height: Get.height / 5,
              ),
              SizedBox(height: Get.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputText(
                        controller: gmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter gmail";
                          } else if (!value.endsWith("@gmail.com")) {
                            return "Please enter a valid gmail";
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "gmail",
                        prefixIcon:
                            const Icon(Icons.email_rounded, color: COLORS.grey),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(
                        () => RoundButton(
                          title: "Recovery",
                          loading: forgetPasswordController.loading.value,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              forgetPasswordController
                                  .forgetPassword(gmailController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
