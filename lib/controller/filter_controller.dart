import 'package:furniture_app/controller/products_controller.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  RxString categorySelected = RxString("all products");
  RxString searchText = RxString("");
  RxList<ProductModel> filteredProducts = RxList();
  RxList<ProductModel> allProducts = RxList();

  void searchProducts(String text) {
    searchText.value = text;
    List<ProductModel> searchList = allProducts
        .where((item) => item.name!.toLowerCase().contains(text.toLowerCase()))
        .toList();

    filteredProducts.value = searchList.obs;
  }

  void filterByCategory(String category) {
    categorySelected.value = category;

    if (category == "all products") {
      filteredProducts.value = allProducts;
    } else {
      List<ProductModel> filterList =
          allProducts.where((item) => item.category == category).toList();

      filteredProducts.value = filterList.obs;
    }
  }
}
