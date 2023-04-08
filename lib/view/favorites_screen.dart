import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/controller/details_product_controller.dart';
import 'package:furniture_app/controller/favorite_controller.dart';
import 'package:furniture_app/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../config/app_styles.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoriteController favoriteController = Get.put(FavoriteController());
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLORS.bg,
        appBar: AppBar(
          backgroundColor: COLORS.bg,
          elevation: 0,
          title: Text(
            'favorites',
            style: fEncodeSansBold.copyWith(fontSize: 20, color: COLORS.dark),
          ),
        ),
        body: Obx(
          () => favoriteController.favoriteList.isEmpty
              ? Lottie.asset(ANIMATIONS.favorite)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      MasonryGridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 30,
                        crossAxisCount: 2,
                        physics: const BouncingScrollPhysics(),
                        itemCount: favoriteController.favoriteList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.find<DetailsProductController>()
                                  .getDetailsProduct(favoriteController
                                      .favoriteList[index].id!);
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: Get.width / 2.5,
                                      height: Get.height / 4,
                                      child: CachedNetworkImage(
                                        imageUrl: favoriteController
                                            .favoriteList[index].image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                              favoriteController
                                                  .favoriteList[index]);
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
                                                      .any((item) =>
                                                          item.id ==
                                                          favoriteController
                                                              .favoriteList[
                                                                  index]
                                                              .id)
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
                                        favoriteController
                                            .favoriteList[index].name!,
                                        textAlign: TextAlign.start,
                                        style: fEncodeSansBold,
                                      ),
                                      Text(
                                        favoriteController
                                            .favoriteList[index].category!,
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
                                              favoriteController
                                                  .favoriteList[index].price!,
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
                      SizedBox(height: Get.height / 7),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
