import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");

  void updateUserName() {
    ref.child(SessionController().userId.toString()).update({
      "userName": usernameController.text.toString(),
    }).then((value) {
      usernameController.clear();
      Get.snackbar("success", "updated username");
    });
  }
}
