import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/view/main_screen.dart';
import 'package:get/get.dart';

import '../services/session_manager.dart';

class LoginController extends GetxController {
  RxBool loading = RxBool(false);

  FirebaseAuth auth = FirebaseAuth.instance;

  setLoading(bool value) {
    loading.value = value;
  }

  void login(String email, String password) async {
    setLoading(true);
    try {
      final user = await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        SessionController().userId = value.user!.uid.toString();

        setLoading(false);

        Get.off(() => const MainScreen());
        Get.snackbar('success', 'user login successful');
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
