import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/view/login_screen.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool loading = RxBool(false);

  FirebaseAuth auth = FirebaseAuth.instance;

  setLoading(bool value) {
    loading.value = value;
  }

  void forgetPassword(String email) async {
    setLoading(true);
    try {
      final user = await auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        setLoading(false);

        Get.offAll(() => const LoginScreen());
        Get.snackbar(
            'success', 'Please check your email to reset your password');
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
