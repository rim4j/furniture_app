import 'package:furniture_app/controller/products_controller.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<ProductModel> favoriteList = RxList();

  toggleFavorite(ProductModel product) {
    if (favoriteList.isEmpty) {
      favoriteList.add(product);
    } else {
      if (!favoriteList.contains(product)) {
        favoriteList.add(product);
      } else {
        favoriteList.remove(product);
      }
    }
  }
}
