import 'package:flutter/material.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:furniture_app/constants/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
        ],
      ),
    );
  }
}
