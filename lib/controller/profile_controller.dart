import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:furniture_app/services/session_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool loading = RxBool(false);

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  setLoading(bool value) {
    loading.value = value;
  }

  void updateUserName() {
    ref.child(SessionController().userId.toString()).update({
      "userName": usernameController.text.toString(),
    }).then((value) {
      usernameController.clear();
      Get.snackbar("success", "updated username");
    });
  }

  Future pickGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
    }
  }

  Future pickCameraImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage();
    }
  }

  void uploadImage() async {
    try {
      setLoading(true);
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref("/profileImage${SessionController().userId}");

      firebase_storage.UploadTask uploadTask =
          storageRef.putFile(File(image!.path).absolute);

      await Future.value(uploadTask);

      final newUrl = await storageRef.getDownloadURL();

      ref.child(SessionController().userId.toString()).update({
        "profile": newUrl.toString(),
      }).then((value) {
        Get.snackbar(
            "success", "profile picture has been updated successfully");
        setLoading(false);
        _image = null;
      }).onError((error, stackTrace) {
        Get.snackbar("error", error.toString());
        setLoading(false);
      });
    } catch (e) {
      print('error ');
    }
  }
}
