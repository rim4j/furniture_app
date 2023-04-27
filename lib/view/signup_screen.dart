import 'package:flutter/material.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/controller/signup_controller.dart';
import 'package:get/get.dart';

import '../components/input_text.dart';
import '../components/round_button.dart';
import '../constants/images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObsecured = true;

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      appBar: AppBar(
        backgroundColor: COLORS.bg,
        iconTheme: const IconThemeData(color: COLORS.dark),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "sign up",
          style: fEncodeSansBold.copyWith(
            color: COLORS.dark,
            fontSize: largeFontSize,
          ),
        ),
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
                        controller: usernameController,
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
                        keyBoardType: TextInputType.name,
                        hint: "username",
                        prefixIcon:
                            const Icon(Icons.person, color: COLORS.grey),
                      ),
                      SizedBox(height: Get.height * 0.02),
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
                      InputText(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 7) {
                            return "at least enter 6 characters";
                          } else if (value.length > 13) {
                            return "maximum characters is 13";
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "password",
                        prefixIcon:
                            const Icon(Icons.lock_open, color: COLORS.grey),
                        obscureText: _isObsecured,
                        suffixIcon: IconButton(
                          color: COLORS.grey,
                          onPressed: () {
                            setState(() {
                              _isObsecured = !_isObsecured;
                            });
                          },
                          icon: Icon(
                            _isObsecured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Obx(
                        () => RoundButton(
                          title: "Sign up",
                          loading: signUpController.loading.value,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              signUpController.signUp(
                                  usernameController.text,
                                  gmailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
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
