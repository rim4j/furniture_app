import 'package:flutter/material.dart';
import 'package:furniture_app/components/input_text.dart';
import 'package:furniture_app/components/round_button.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/controller/auth/login_controller.dart';
import 'package:furniture_app/view/forget_password_screen.dart';
import 'package:furniture_app/view/signup_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      appBar: AppBar(
        title: Text(
          "Login",
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
                      SizedBox(height: Get.height * 0.02),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgetPasswordScreen());
                          },
                          child: Text(
                            'Forget Password',
                            style: fEncodeSansMedium.copyWith(
                              fontSize: smallFontSize,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(
                        () => RoundButton(
                          title: "Login",
                          loading: loginController.loading.value,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              loginController.login(gmailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      GestureDetector(
                        onTap: () => Get.to(() => const SignUpScreen()),
                        child: Text.rich(TextSpan(
                            text: "Don't have an account?",
                            style: fEncodeSansMedium.copyWith(
                              fontSize: smallFontSize,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: fEncodeSansMedium.copyWith(
                                  fontSize: smallFontSize,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ])),
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
