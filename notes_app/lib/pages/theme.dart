import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color.fromARGB(255, 96, 12, 207);
const Color yelloClr = Color.fromARGB(255, 255, 190, 48);
const Color pinkClr = Color(0xffFF0B6B);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreayClr = Color(0xff303030);
const Color darkHeaderClr = Color.fromARGB(255, 49, 49, 49);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: darkGreayClr,
    brightness: Brightness.dark,
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
    ),
  );
}
