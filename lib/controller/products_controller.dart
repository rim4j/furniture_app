import 'package:furniture_app/constants/url.dart';
import 'package:furniture_app/controller/filter_controller.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/services/dio_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  RxList<ProductModel> products = RxList();
  //  var productList = <ProductModel>[].obs;
  RxList<String> category = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getProducts();
  }

  getProducts() async {
    loading.value = true;
    try {
      var response = await DioService().getMethod(URL.productsUrl);
      if (response.statusCode == 200) {
        response.data
            .forEach((item) => products.add(ProductModel.fromJson(item)));
        response.data.forEach((item) => Get.find<FilterController>()
            .allProducts
            .add(ProductModel.fromJson(item)));
        response.data.forEach((item) => Get.find<FilterController>()
            .filteredProducts
            .add(ProductModel.fromJson(item)));

        category.add("all products");
        for (var item in products) {
          if (!category.contains(item.category)) {
            category.add(item.category.toString());
          }
        }

        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }
}
