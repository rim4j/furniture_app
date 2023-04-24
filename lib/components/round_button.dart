import 'package:flutter/material.dart';
import 'package:furniture_app/config/app_styles.dart';
import 'package:get/route_manager.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.color = COLORS.dark,
    this.textColor = Colors.white,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPress,
      child: Container(
        height: Get.height / 16,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: fEncodeSansMedium.copyWith(
                      fontSize: mediumFontSize, color: textColor),
                ),
              ),
      ),
    );
  }
}
