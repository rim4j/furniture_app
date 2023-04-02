import 'package:furniture_app/constants/url.dart';
import 'package:furniture_app/models/details_product_model.dart';
import 'package:furniture_app/services/dio_service.dart';
import 'package:furniture_app/view/details_screen.dart';
import 'package:get/get.dart';

class DetailsProductController extends GetxController {
  RxBool loading = false.obs;
  Rx<DetailsProductModel> detailsProduct = DetailsProductModel().obs;

  getDetailsProduct(String id) async {
    Get.to(() => DetailsScreen());
    loading.value = true;

    var response = await DioService().getMethod("${URL.singleProductUrl}$id");
    if (response.statusCode == 200) {
      loading.value = false;
      detailsProduct.value = DetailsProductModel.fromJson(response.data);
    }
  }
}
