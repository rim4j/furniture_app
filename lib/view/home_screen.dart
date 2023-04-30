import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/data_list.dart';
import 'package:furniture_app/constants/icons_data.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/controller/details_product_controller.dart';
import 'package:furniture_app/controller/favorite_controller.dart';
import 'package:furniture_app/controller/filter_controller.dart';
import 'package:furniture_app/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../services/session_manager.dart';
import '../utils/convert_hex.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductsController productsController = Get.put(ProductsController());
  final FilterController filterController = Get.put(FilterController());
  final DetailsProductController detailsProductController =
      Get.put(DetailsProductController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  final ref = FirebaseDatabase.instance.ref("User");

  final RxDouble price = RxDouble(0.0);

  @override
  Widget build(BuildContext context) {
    //bottom sheet
    void showAsBottomSheet() async {
      await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 20,
          avoidStatusBar: true,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.8, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: COLORS.grey,
                    borderRadius: BorderRadius.circular(500),
                  ),
                ),
              ),
            ],
          ),
          builder: (context, state) {
            return SizedBox(
                width: Get.width,
                child: Material(
                  color: COLORS.bg,
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "price",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: mediumFontSize,
                                color: COLORS.dark,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Slider(
                                    activeColor: COLORS.dark,
                                    inactiveColor: COLORS.lightGrey,
                                    value: filterController.selectedPrice.value,
                                    min: filterController.minPrice.value,
                                    max: filterController.maxPrice.value,
                                    onChanged: (double value) {
                                      filterController.selectedPrice.value =
                                          value;
                                    },
                                  ),
                                  Text(
                                    "\$${NumberFormat().format(filterController.selectedPrice.value)}",
                                    style: fEncodeSansRegular.copyWith(
                                      color: COLORS.dark,
                                      fontSize: mediumFontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          //sort by name and price

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "sort by",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: mediumFontSize,
                                color: COLORS.dark,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: SizedBox(
                              width: Get.width,
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: filterController
                                    .sortByNameAndPriceList.length,
                                itemBuilder: (context, index) {
                                  final item = filterController
                                      .sortByNameAndPriceList[index];
                                  return Obx(
                                    () => InkWell(
                                      onTap: () {
                                        filterController
                                            .filterByNameAndPriceSelected
                                            .value = item.value!;
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: COLORS.grey,
                                                ),
                                              ),
                                              child: filterController
                                                          .filterByNameAndPriceSelected
                                                          .value ==
                                                      item.value
                                                  ? Center(
                                                      child: Lottie.asset(
                                                        repeat: false,
                                                        ANIMATIONS.checkMark,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            item.title!,
                                            style: fEncodeSansRegular.copyWith(
                                                fontSize: smallFontSize),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sort by company

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "company",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: mediumFontSize,
                                color: COLORS.dark,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: filterController.companyList.length,
                              itemBuilder: (context, index) {
                                final company =
                                    filterController.companyList[index];
                                final companySelected =
                                    filterController.companySelected;

                                return Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      filterController.companySelected.value =
                                          company;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color:
                                              companySelected.value == company
                                                  ? COLORS.dark
                                                  : COLORS.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            company,
                                            style: fEncodeSansRegular.copyWith(
                                              fontSize: smallFontSize,
                                              color: companySelected.value ==
                                                      company
                                                  ? COLORS.lightGrey
                                                  : COLORS.dark,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 20),
                          //sort by colors

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "colors",
                              style: fEncodeSansMedium.copyWith(
                                fontSize: mediumFontSize,
                                color: COLORS.dark,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: Get.width,
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: filterController.colorList.length,
                              itemBuilder: (context, index) {
                                //convert to hex
                                Color colorItem = HexColor(
                                  filterController.colorList[index],
                                );
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        filterController.colorSelected.value =
                                            filterController.colorList[index];
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: colorItem,
                                          shape: BoxShape.circle,
                                        ),
                                        child: filterController
                                                    .colorSelected.value ==
                                                filterController
                                                    .colorList[index]
                                            ? Center(
                                                child: Lottie.asset(
                                                  ANIMATIONS.lightCheckMark,
                                                  repeat: false,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),
                          // buttons
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      filterController.clearFilter();
                                      Get.back();
                                    },
                                    child: Text(
                                      "clear",
                                      style: fEncodeSansMedium.copyWith(
                                          fontSize: smallFontSize),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        backgroundColor: COLORS.dark,
                                      ),
                                      child: Text(
                                        "done",
                                        style: fEncodeSansMedium.copyWith(
                                            fontSize: smallFontSize),
                                      ),
                                      onPressed: () {
                                        filterController.filterInBottomSheet();
                                        Get.back();
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      });
    }
    //end bottom sheet

    return Scaffold(
      backgroundColor: COLORS.bg,
      body: SafeArea(
        child: Obx(
          () => productsController.loading.value == false
              ? RefreshIndicator(
                  backgroundColor: COLORS.dark,
                  color: COLORS.lightGrey,
                  onRefresh: () async {
                    productsController.products.clear();
                    productsController.category.clear();
                    productsController.getProducts();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //!header
                        Column(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: StreamBuilder(
                                  stream: ref
                                      .child(
                                          SessionController().userId.toString())
                                      .onValue,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: COLORS.dark,
                                      ));
                                    } else if (snapshot.hasData) {
                                      Map<dynamic, dynamic> map =
                                          snapshot.data.snapshot.value;

                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                IMAGES.logo,
                                                scale: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Hello, Welcome 👋",
                                                    style: fEncodeSansBold
                                                        .copyWith(
                                                      color: COLORS.dark,
                                                      fontSize: smallFontSize,
                                                    ),
                                                  ),
                                                  Text(
                                                    map["userName"],
                                                    style: fEncodeSansBold
                                                        .copyWith(
                                                      color: COLORS.dark,
                                                      fontSize:
                                                          verySmallFontSize,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              map["profile"] == ""
                                                  ? "https://t4.ftcdn.net/jpg/04/70/29/97/240_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                                                  : map["profile"].toString(),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                          child: Text(
                                        "somethings went wrong",
                                        style: fEncodeSansBold.copyWith(
                                            fontSize: largeFontSize),
                                      ));
                                    }
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // !search field

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: fEncodeSansRegular.copyWith(
                                    color: COLORS.dark,
                                    fontSize: 14,
                                  ),
                                  onChanged: (value) {
                                    filterController.searchProducts(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    prefixIcon: const IconTheme(
                                      data: IconThemeData(color: COLORS.grey),
                                      child: Icon(Icons.search),
                                    ),
                                    hintText: "Search ...",
                                    border: fInputBorder,
                                    disabledBorder: fInputBorder,
                                    focusedBorder: fInputBorder,
                                    focusedErrorBorder: fInputBorder,
                                    enabledBorder: fInputBorder,
                                    hintStyle: fEncodeSansRegular.copyWith(
                                        color: COLORS.grey,
                                        fontSize: smallFontSize),
                                    fillColor: COLORS.lightGrey,
                                    filled: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  showAsBottomSheet();
                                },
                                child: Container(
                                  width: 49,
                                  height: 49,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: COLORS.dark,
                                  ),
                                  child: SvgPicture.asset(ICONS.filter),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // !category

                        SizedBox(
                          width: double.infinity,
                          height: 36,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: productsController.category.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  filterController.filterByCategory(
                                      productsController.category[index]
                                          .toString());
                                },
                                child: Obx(
                                  () => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 24 : 15,
                                      right: index ==
                                              productsController
                                                      .category.length -
                                                  1
                                          ? 24
                                          : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: filterController
                                                  .categorySelected.value ==
                                              productsController.category[index]
                                                  .toString()
                                          ? COLORS.dark
                                          : COLORS.lightGrey,
                                    ),
                                    child: Row(
                                      children: [
                                        //category icon
                                        SvgPicture.asset(
                                          iconsList[index].icon!,
                                          width: 25,
                                          // ignore: deprecated_member_use
                                          color: filterController
                                                      .categorySelected.value ==
                                                  productsController
                                                      .category[index]
                                              ? COLORS.lightGrey
                                              : COLORS.dark,
                                        ),
                                        const SizedBox(width: 10),
                                        //category title
                                        Center(
                                          child: Text(
                                            productsController.category[index],
                                            style: fEncodeSansRegular.copyWith(
                                              fontSize: smallFontSize,
                                              color: filterController
                                                          .categorySelected
                                                          .value ==
                                                      productsController
                                                          .category[index]
                                                          .toString()
                                                  ? COLORS.lightGrey
                                                  : COLORS.dark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        //!list
                        const SizedBox(height: 32),

                        //!filter controller
                        Obx(
                          () => filterController.filteredProducts.isEmpty
                              ? Lottie.asset(ANIMATIONS.notFound)
                              : MasonryGridView.count(
                                  shrinkWrap: true,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 30,
                                  crossAxisCount: 2,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      filterController.filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        detailsProductController
                                            .getDetailsProduct(filterController
                                                .filteredProducts[index].id!);
                                      },
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                width: Get.width / 2.5,
                                                height: Get.height / 4,
                                                child: CachedNetworkImage(
                                                  imageUrl: filterController
                                                      .filteredProducts[index]
                                                      .image!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Lottie.asset(
                                                          ANIMATIONS.loading),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    favoriteController
                                                        .toggleFavorite(
                                                      filterController
                                                              .filteredProducts[
                                                          index],
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: COLORS.dark,
                                                    ),
                                                    child: Obx(
                                                      () => Icon(
                                                        favoriteController
                                                                .favoriteList
                                                                .contains(
                                                                    filterController
                                                                            .filteredProducts[
                                                                        index])
                                                            ? CupertinoIcons
                                                                .heart_solid
                                                            : CupertinoIcons
                                                                .suit_heart,
                                                        size: 18,
                                                        color: favoriteController
                                                                .favoriteList
                                                                .contains(
                                                                    filterController
                                                                            .filteredProducts[
                                                                        index])
                                                            ? Colors.red
                                                            : COLORS.lightGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: Get.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filterController
                                                      .filteredProducts[index]
                                                      .name!,
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      fEncodeSansBold.copyWith(
                                                    fontSize: smallFontSize,
                                                  ),
                                                ),
                                                Text(
                                                  filterController
                                                      .filteredProducts[index]
                                                      .category!,
                                                  textAlign: TextAlign.start,
                                                  style: fEncodeSansMedium
                                                      .copyWith(
                                                    color: COLORS.grey,
                                                    fontSize: verySmallFontSize,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "\$${NumberFormat().format(
                                                        filterController
                                                            .filteredProducts[
                                                                index]
                                                            .price!,
                                                      )}",
                                                      style: fEncodeSansBold
                                                          .copyWith(
                                                        fontSize: smallFontSize,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(height: Get.height / 7),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Lottie.asset(ANIMATIONS.loading, width: 250),
                ),
        ),
      ),
    );
  }
}
