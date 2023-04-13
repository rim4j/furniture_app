import 'package:furniture_app/constants/url.dart';
import 'package:furniture_app/controller/filter_controller.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/services/dio_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  RxList<ProductModel> products = RxList();
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

        Get.find<FilterController>().allProducts.value = products;
        Get.find<FilterController>().filteredProducts.value = products;

        //init company list
        for (var item in products) {
          if (!Get.find<FilterController>()
              .companyList
              .contains(item.company)) {
            Get.find<FilterController>()
                .companyList
                .add(item.company.toString());
          }
        }

        for (var item in products) {
          //init all prices list
          if (!Get.find<FilterController>().priceList.contains(item.price)) {
            Get.find<FilterController>().priceList.add(item.price!.toDouble());
          }
          //init color list
          for (var color in item.colors!) {
            if (!Get.find<FilterController>().colorList.contains(color)) {
              Get.find<FilterController>().colorList.add(color);
            }
          }
        }

        //init min and max price
        var maxPrice = Get.find<FilterController>()
            .priceList
            .reduce((a, b) => a > b ? a : b);
        Get.find<FilterController>().maxPrice.value = maxPrice;
        Get.find<FilterController>().selectedPrice.value = maxPrice;

        var minPrice = Get.find<FilterController>()
            .priceList
            .reduce((a, b) => a < b ? a : b);
        Get.find<FilterController>().minPrice.value = minPrice;

        //init category list
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
