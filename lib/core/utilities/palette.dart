import 'package:flutter/material.dart';

class Palette {
  static Color primaryColor = hexToColor("#BB00DA");
  static const Color lightPrimaryColor = Color(0xFFFCDDFF);
  static const textInputFieldColor = Color.fromARGB(255, 245, 223, 223);
  static Color gobackButtonColor = hexToColor('#FFDFFC');
  static Color superLikeColor = hexToColor('#CA13B8');
  static Color bottomNavBgColor = hexToColor('#F3F3F3');
  static Color filterTileBg = hexToColor('#FBFBFB');
  static Color lightRed = hexToColor('#FDECEE');

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
