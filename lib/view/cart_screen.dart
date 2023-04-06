import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/components/furniture_divider.dart';
import 'package:furniture_app/constants/images.dart';
import 'package:furniture_app/controller/cart_controller.dart';
import 'package:furniture_app/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../config/app_styles.dart';
import '../utils/convert_hex.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.put(CartController());
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
            'checkout',
            style: fEncodeSansBold.copyWith(fontSize: 20, color: COLORS.dark),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => cartController.cartList.isEmpty
                ? Lottie.asset(ANIMATIONS.emptyCart)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MasonryGridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 1,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartController.cartList.length,
                        itemBuilder: (context, index) {
                          Color colorItem = HexColor(
                            cartController.cartList[index].color!,
                          );
                          return Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.3,
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        cartController.removeProduct(index);
                                      },
                                      backgroundColor: Colors.red,
                                      icon: CupertinoIcons.trash,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: cartController
                                                  .cartList[index].image!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //name and price
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: Get.width / 3.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartController
                                                      .cartList[index].name!,
                                                  style:
                                                      fEncodeSansBold.copyWith(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  cartController.cartList[index]
                                                      .category!,
                                                  style: fEncodeSansMedium
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color: COLORS.grey,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "\$${NumberFormat().format(cartController.cartList[index].price)}",
                                                  style: fEncodeSansBold
                                                      .copyWith(fontSize: 16),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: colorItem,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          //increase and decrease items
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.decrease(
                                                      cartController
                                                          .cartList[index].id!);
                                                  cartController
                                                      .calculateAmountAndTotal();
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
                                                  cartController
                                                      .cartList[index].amount
                                                      .toString(),
                                                  style: fEncodeSansBold
                                                      .copyWith(fontSize: 20),
                                                )),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.increase(
                                                      cartController
                                                          .cartList[index].id!);
                                                  cartController
                                                      .calculateAmountAndTotal();
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
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            furnitureDivider(),
                            const SizedBox(height: 20),
                            Text(
                              "shipping information",
                              style: fEncodeSansSemibold.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "total price : ",
                                    style: fEncodeSansSemibold.copyWith(
                                      fontSize: 18,
                                      color: COLORS.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${NumberFormat().format(cartController.totalPrice.value)}",
                                  style: fEncodeSansSemibold.copyWith(
                                    fontSize: 18,
                                    color: COLORS.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "total amount : ",
                                    style: fEncodeSansSemibold.copyWith(
                                      fontSize: 18,
                                      color: COLORS.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${cartController.totalAmount}",
                                  style: fEncodeSansSemibold.copyWith(
                                    fontSize: 18,
                                    color: COLORS.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height / 9),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
