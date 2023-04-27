import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:furniture_app/view/login_screen.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void logout() {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signOut().then((value) {
      SessionController().userId = "";
      Get.off(() => const LoginScreen());
      Get.snackbar("success", "user logged out successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(SessionController().userId.toString()),
            ElevatedButton(
              onPressed: () => logout(),
              child: const Text('log out'),
            )
          ],
        ),
      ),
    );
  }
}
