import 'package:furniture_app/models/cart_product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartProductModel> cartList = RxList();
  RxInt totalAmount = RxInt(0);
  RxDouble totalPrice = RxDouble(0);

  addProduct(CartProductModel product) {
    var isExist = cartList.where((item) => item.id == product.id);
    if (isExist.isEmpty) {
      cartList.add(product);

      Get.snackbar(
        "${product.name}",
        "added to the shopping cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      for (var item in cartList) {
        if (item.id == product.id) {
          int newAmount = item.amount! + product.amount!;

          if (newAmount > item.stock!) {
            item.amount = item.stock;
          } else {
            item.amount = newAmount;
          }
        }
      }
    }
  }

  removeProduct(int index) {
    cartList.removeAt(index);
    if (cartList.isEmpty) {
      totalAmount.value = 0;
      totalPrice.value = 0;
    } else {
      calculateAmountAndTotal();
    }
  }

  increase(String id) {
    for (var item in cartList) {
      if (id == item.id) {
        if (item.amount! >= item.stock!) {
          item.amount = item.stock;
        } else {
          item.amount = item.amount! + 1;
        }
      }
    }
  }

  decrease(String id) {
    for (var item in cartList) {
      if (id == item.id) {
        if (item.amount == 1) {
          item.amount = item.amount;
        } else {
          item.amount = item.amount! - 1;
        }
      }
    }
  }

  calculateAmountAndTotal() {
    var calculatedAmount = cartList
        .map((item) => item.amount)
        .reduce((value, element) => value! + element!);

    var allTotal = cartList.fold<double>(0.0, (previousValue, item) {
      return previousValue + item.price! * item.amount!;
    });

    totalAmount.value = calculatedAmount!;
    totalPrice.value = allTotal;
  }
}
