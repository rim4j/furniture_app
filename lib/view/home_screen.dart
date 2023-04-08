import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/icons_data.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/controller/details_product_controller.dart';
import 'package:furniture_app/controller/favorite_controller.dart';
import 'package:furniture_app/controller/filter_controller.dart';
import 'package:furniture_app/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductsController productsController = Get.put(ProductsController());
  final FilterController filterController = Get.put(FilterController());
  final DetailsProductController detailsProductController =
      Get.put(DetailsProductController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => productsController.loading.value == false
            ? ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              IMAGES.logo,
                              scale: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hello, Welcome 👋",
                                  style: fEncodeSansBold.copyWith(
                                    color: COLORS.dark,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "John Doe",
                                  style: fEncodeSansBold.copyWith(
                                    color: COLORS.dark,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://xsgames.co/randomusers/assets/avatars/male/74.jpg"),
                        ),
                      ],
                    ),
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
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 13),
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
                                  color: COLORS.grey, fontSize: 14),
                              fillColor: COLORS.lightGrey,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {},
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
                            filterController.categorySelected.value =
                                productsController.category[index].toString();
                          },
                          child: Obx(
                            () => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.only(
                                left: index == 0 ? 24 : 15,
                                right: index ==
                                        productsController.category.length - 1
                                    ? 24
                                    : 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    filterController.categorySelected.value ==
                                            productsController.category[index]
                                                .toString()
                                        ? COLORS.dark
                                        : COLORS.lightGrey,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    iconsList[index].icon!,
                                    width: 25,
                                    // ignore: deprecated_member_use
                                    color: filterController
                                                .categorySelected.value ==
                                            productsController.category[index]
                                        ? COLORS.lightGrey
                                        : COLORS.dark,
                                  ),
                                  const SizedBox(width: 10),
                                  Center(
                                    child: Text(
                                      productsController.category[index],
                                      style: fEncodeSansRegular.copyWith(
                                        fontSize: 14,
                                        color: filterController
                                                    .categorySelected.value ==
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
                  Obx(
                    () => MasonryGridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 30,
                      crossAxisCount: 2,
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsController.products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            detailsProductController.getDetailsProduct(
                                productsController.products[index].id!);
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: Get.width / 2.5,
                                    height: Get.height / 4,
                                    child: CachedNetworkImage(
                                      imageUrl: productsController
                                          .products[index].image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Lottie.asset(ANIMATIONS.loading),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        favoriteController.toggleFavorite(
                                          productsController.products[index],
                                        );
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: COLORS.dark,
                                        ),
                                        child: Obx(
                                          () => Icon(
                                            CupertinoIcons.heart_solid,
                                            size: 18,
                                            color: favoriteController
                                                    .favoriteList
                                                    .contains(productsController
                                                        .products[index])
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productsController.products[index].name!,
                                      textAlign: TextAlign.start,
                                      style: fEncodeSansBold,
                                    ),
                                    Text(
                                      productsController
                                          .products[index].category!,
                                      textAlign: TextAlign.start,
                                      style: fEncodeSansMedium.copyWith(
                                        color: COLORS.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\$${NumberFormat().format(
                                            productsController
                                                .products[index].price!,
                                          )}",
                                          style: fEncodeSansBold,
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
              )
            : Center(
                child: Lottie.asset(ANIMATIONS.loading, width: 250),
              ),
      ),
    );
  }
}
