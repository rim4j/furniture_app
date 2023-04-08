import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/controller/cart_controller.dart';
import 'package:furniture_app/controller/favorite_controller.dart';
import 'package:furniture_app/controller/products_controller.dart';
import 'package:furniture_app/models/cart_product_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/utils/convert_hex.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/furniture_divider.dart';
import '../config/app_styles.dart';
import '../constants/images.dart';
import '../controller/details_product_controller.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final DetailsProductController detailsProductController =
      Get.put(DetailsProductController());

  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  final PageController _indicatorController = PageController();

  final RxInt count = RxInt(1);
  final RxInt selectedColorIndex = RxInt(0);

  @override
  Widget build(BuildContext context) {
    var statusHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: COLORS.bg,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //add to cart button
      floatingActionButton: Obx(
        () => detailsProductController.loading.value == false
            ? GestureDetector(
                onTap: () {
                  if (detailsProductController.detailsProduct.value.stock !=
                      0) {
                    var selectedColor = detailsProductController
                        .detailsProduct.value.colors![selectedColorIndex.value];

                    cartController.addProduct(
                      CartProductModel(
                        amount: count.value,
                        category: detailsProductController
                            .detailsProduct.value.category,
                        color: selectedColor,
                        id: detailsProductController.detailsProduct.value.id! +
                            selectedColor,
                        name:
                            detailsProductController.detailsProduct.value.name,
                        image: detailsProductController
                            .detailsProduct.value.images![0]["url"],
                        price:
                            detailsProductController.detailsProduct.value.price,
                        stock:
                            detailsProductController.detailsProduct.value.stock,
                      ),
                    );
                    cartController.calculateAmountAndTotal();
                  }
                },
                child: Container(
                  height: Get.height / 13,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color:
                        detailsProductController.detailsProduct.value.stock == 0
                            ? COLORS.grey
                            : COLORS.dark,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ICONS.shoppingCart),
                      const SizedBox(width: 8),
                      Text(
                        "add to cart |",
                        style: fEncodeSansBold.copyWith(
                          fontSize: 18,
                          color: COLORS.lightGrey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${NumberFormat().format(detailsProductController.detailsProduct.value.price)}",
                        style: fEncodeSansBold.copyWith(
                          fontSize: 18,
                          color: COLORS.lightGrey,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ),
      body: Obx(
        () => detailsProductController.loading.value == false
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 2.3,
                      child: Stack(
                        children: [
                          PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _indicatorController,
                            itemCount: detailsProductController
                                .detailsProduct.value.images!.length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: detailsProductController
                                    .detailsProduct.value.images![index]['url'],
                                placeholder: (context, url) {
                                  return Container(
                                    child: Lottie.asset(ANIMATIONS.loading),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          //icons
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                20, statusHeight + 5, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: COLORS.lightGrey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: COLORS.dark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var products =
                                        Get.find<ProductsController>().products;
                                    var findProduct = products.firstWhere(
                                        (item) =>
                                            item.id ==
                                            detailsProductController
                                                .detailsProduct.value.id);

                                    favoriteController
                                        .toggleFavorite(findProduct);
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: COLORS.lightGrey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Obx(
                                      () => Icon(
                                        CupertinoIcons.heart_solid,
                                        size: 24,
                                        color: favoriteController.favoriteList
                                                .any((item) =>
                                                    item.id ==
                                                    detailsProductController
                                                        .detailsProduct
                                                        .value
                                                        .id)
                                            ? Colors.red
                                            : COLORS.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //dots indicator
                          Container(
                            alignment: const Alignment(0, 0.9),
                            child: SmoothPageIndicator(
                              controller: _indicatorController,
                              count: detailsProductController
                                  .detailsProduct.value.images!.length,
                              effect: const ScrollingDotsEffect(
                                activeDotColor: COLORS.dark,
                                dotColor: COLORS.grey,
                                dotWidth: 10,
                                dotHeight: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //title and count selected user
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width / 2,
                            child: Text(
                              detailsProductController
                                  .detailsProduct.value.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: fEncodeSansBold.copyWith(fontSize: 24),
                            ),
                          ),
                          Row(
                            children: detailsProductController
                                        .detailsProduct.value.stock ==
                                    0
                                ? [
                                    Text(
                                      "out of stock",
                                      style: fEncodeSansRegular.copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ]
                                : [
                                    GestureDetector(
                                      onTap: () {
                                        if (count.value == 1) {
                                          count.value = 1;
                                        } else {
                                          count.value = count.value - 1;
                                        }
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: COLORS.lightGrey,
                                              width: 2),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          color: COLORS.dark,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        count.value.toString(),
                                        style: fEncodeSansBold.copyWith(
                                            fontSize: 20),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (count.value ==
                                            detailsProductController
                                                .detailsProduct.value.stock) {
                                          count.value;
                                        } else {
                                          count.value = count.value + 1;
                                        }
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: COLORS.lightGrey,
                                              width: 2),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: COLORS.dark,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                          )
                        ],
                      ),
                    ),

                    //star rating and reviews

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 24,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.all(2),
                            unratedColor: COLORS.grey,
                            initialRating: detailsProductController
                                .detailsProduct.value.stars!,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: COLORS.yellow,
                              );
                            },
                            onRatingUpdate: (value) {
                              print(value);
                            },
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${detailsProductController.detailsProduct.value.stars}",
                            style: fEncodeSansRegular.copyWith(
                              color: COLORS.grey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "(reviews ${detailsProductController.detailsProduct.value.reviews})",
                            style:
                                fEncodeSansRegular.copyWith(color: COLORS.grey),
                          )
                        ],
                      ),
                    ),
                    //description
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: ReadMoreText(
                        detailsProductController
                            .detailsProduct.value.description!,
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'show more',
                        trimExpandedText: ' show less',
                        moreStyle: fEncodeSansBold,
                        lessStyle: fEncodeSansBold,
                        style: fEncodeSansRegular.copyWith(height: 1.8),
                      ),
                    ),
                    furnitureDivider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "available:",
                                  style: fEncodeSansBold.copyWith(fontSize: 16),
                                ),
                              ),
                              Text(
                                detailsProductController
                                            .detailsProduct.value.stock ==
                                        0
                                    ? "out of stock"
                                    : "in stock",
                                style:
                                    fEncodeSansRegular.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "SKU:",
                                  style: fEncodeSansBold.copyWith(fontSize: 16),
                                ),
                              ),
                              Text(
                                detailsProductController
                                    .detailsProduct.value.id!,
                                style:
                                    fEncodeSansRegular.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "brand:",
                                  style: fEncodeSansBold.copyWith(fontSize: 16),
                                ),
                              ),
                              Text(
                                detailsProductController
                                    .detailsProduct.value.company!,
                                style:
                                    fEncodeSansRegular.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          //list select color
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detailsProductController
                                  .detailsProduct.value.colors!.length,
                              itemBuilder: (context, index) {
                                //convert to hex
                                Color colorItem = HexColor(
                                  detailsProductController
                                      .detailsProduct.value.colors![index],
                                );
                                return GestureDetector(
                                  onTap: () {
                                    // print(detailsProductController
                                    //     .detailsProduct.value.colors![index]);
                                    selectedColorIndex.value = index;
                                  },
                                  child: Obx(
                                    () => detailsProductController
                                                .detailsProduct.value.stock !=
                                            0
                                        ? Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(colorItem.value),
                                              shape: BoxShape.circle,
                                            ),
                                            child: selectedColorIndex == index
                                                ? const Icon(
                                                    CupertinoIcons
                                                        .check_mark_circled,
                                                    color: COLORS.lightGrey,
                                                  )
                                                : const SizedBox(),
                                          )
                                        : const SizedBox(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: Get.height / 7),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Lottie.asset(ANIMATIONS.loading, width: 250),
              ),
      ),
    );
  }
}
