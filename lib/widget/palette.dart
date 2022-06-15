import 'package:flutter/material.dart';

Color darkGreyColor = HexColor("#6D6585");
Color whiteColor = Colors.white;
Color blueColor = HexColor("#5E00E4");
Color descriptionTextColor = HexColor("#4E4B66");
Color blackColor = HexColor("#14142B");
Color greyColor = HexColor("#A0A3BD");
Color whiteTextColor = HexColor("#FCFCFC");
Color lightPurpleColor = HexColor("#EFF0F6");
Color commentTextColor = HexColor("#6E7191");

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
