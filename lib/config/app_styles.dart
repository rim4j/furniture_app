import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class COLORS {
  static const Color bg = Color.fromARGB(255, 255, 255, 255);
  static const Color lightGrey = Color.fromARGB(255, 250, 250, 250);
  static const Color grey = Color.fromARGB(255, 159, 159, 159);
  static const Color dark = Color.fromARGB(255, 15, 15, 15);
  static const Color yellow = Color.fromARGB(255, 255, 211, 60);
}

final fInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: COLORS.lightGrey),
);

final blockSizeHorizontal = Get.width / 100;
final blockSizeVertical = Get.height / 100;

final veryLargeFontSize = blockSizeHorizontal * 4.5;
final largeFontSize = blockSizeHorizontal * 4;
final mediumFontSize = blockSizeHorizontal * 3.5;
final smallFontSize = blockSizeHorizontal * 3;
final verySmallFontSize = blockSizeHorizontal * 2.5;

final fEncodeSansBold = GoogleFonts.encodeSans(fontWeight: FontWeight.w700);
final fEncodeSansSemibold = GoogleFonts.encodeSans(fontWeight: FontWeight.w600);

final fEncodeSansMedium = GoogleFonts.encodeSans(fontWeight: FontWeight.w500);

final fEncodeSansRegular = GoogleFonts.encodeSans(fontWeight: FontWeight.w400);
