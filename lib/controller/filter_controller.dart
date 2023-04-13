import 'package:collection/collection.dart';
import 'package:furniture_app/constants/data_list.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  RxString categorySelected = RxString("all products");
  RxString searchText = RxString("");
  RxList<ProductModel> filteredProducts = RxList();
  RxList<ProductModel> allProducts = RxList();
  RxList<SortByNameAndPrice> sortByNameAndPriceList =
      RxList(sortByNameAndPriceListData);
  RxString filterByNameAndPriceSelected = RxString("");
  RxList<String> companyList = RxList();
  RxString companySelected = RxString("");
  RxList<String> colorList = RxList();
  RxString colorSelected = RxString("");
  RxDouble minPrice = RxDouble(0.0);
  RxDouble maxPrice = RxDouble(0.0);
  RxDouble selectedPrice = RxDouble(0.0);
  RxList<double> priceList = RxList();

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

  void clearFilter() {
    selectedPrice.value = maxPrice.value;
    filterByNameAndPriceSelected.value = "";
    companySelected.value = "";
    colorSelected.value = "";

    filteredProducts.value = allProducts;
  }

  void filterInBottomSheet() {
    //filter by selected price

    RxList<ProductModel> temp = [...allProducts].obs;

    temp.value = temp.where((item) {
      return item.price! <= selectedPrice.value;
    }).toList();

    if (filterByNameAndPriceSelected.value == "lowestPrice") {
      temp.sort((a, b) => a.price!.compareTo(b.price!));
    }

    if (filterByNameAndPriceSelected.value == "highestPrice") {
      temp.sort((a, b) => b.price!.compareTo(a.price!));
    }
    if (filterByNameAndPriceSelected.value == "nameA-Z") {
      temp.sort((a, b) => a.name!.compareTo(b.name!));
    }
    if (filterByNameAndPriceSelected.value == "nameZ-A") {
      temp.sort((a, b) => b.name!.compareTo(a.name!));
    }

    //filter by company

    if (companySelected.value != "") {
      temp.value = temp.where((item) {
        return item.company! == companySelected.value;
      }).toList();
    }

    //filter by colors

    if (colorSelected.value != "") {
      temp.value = temp.where((item) {
        return item.colors!.contains(colorSelected.value);
      }).toList();
    }

    filteredProducts.value = temp;
  }
}
