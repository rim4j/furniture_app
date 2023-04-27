import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import '../config/app_styles.dart';
import 'furniture_divider.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });
  final String title;
  final String value;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                title,
                style: fEncodeSansBold.copyWith(
                  fontSize: mediumFontSize,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: fEncodeSansMedium.copyWith(
                  fontSize: smallFontSize,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
