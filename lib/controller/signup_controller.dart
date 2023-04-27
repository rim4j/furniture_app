import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:furniture_app/view/main_screen.dart';
import 'package:get/get.dart';

import '../services/session_manager.dart';

class SignUpController extends GetxController {
  RxBool loading = RxBool(false);

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");

  setLoading(bool value) {
    loading.value = value;
  }

  void signUp(String username, String email, String password) async {
    setLoading(true);
    try {
      final user = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        SessionController().userId = value.user!.uid.toString();

        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': "noOne",
          "image": "",
          "userName": username,
          "profile": "",
        }).then((value) {
          setLoading(false);
          Get.snackbar("success", 'user successfully created');
          Get.offAll(() => const MainScreen());
        }).onError((error, stackTrace) {
          setLoading(false);
          Get.snackbar("error", error.toString());
        });
      }).onError((error, stackTrace) {
        Get.snackbar("error", error.toString());
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);

      Get.snackbar("error", e.toString());
    }
  }
}
