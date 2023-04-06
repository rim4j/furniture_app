import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../config/app_styles.dart';

Widget furnitureDivider() {
  return Opacity(
    opacity: 0.3,
    child: Container(
      width: Get.width / 1.1,
      height: 1,
      color: COLORS.grey,
    ),
  );
}
