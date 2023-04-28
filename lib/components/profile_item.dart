import 'package:flutter/material.dart';

import '../config/app_styles.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final String value;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
