import 'package:flutter/material.dart';

class
Palette {
  static Color primaryColor = hexToColor("#BB00DA");
  static  Color lightPrimaryColor = hexToColor("#BB00DA");
  static  Color customGrey = hexToColor("#8B8B8B");
  static const textInputFieldColor = Color.fromARGB(255, 245, 223, 223);
  static Color superLikeColor = hexToColor('#CA13B8');
  static Color bottomNavBgColor = hexToColor('#F3F3F3');
  static Color lightRed = hexToColor('#FDECEE');
  static Color backgroundColor = Color(0xFFF6F6F6);
  static const Color transparent = Colors.transparent;
  static Color facebookColor = hexToColor('#0037C1');
  static Color infoYellow = hexToColor('#FFCA0D');
  static Color yellow = hexToColor('#FCF3A7');
  static Color drawerIconsColor = hexToColor('#7A7694');
  static Color deepBackgroundColor = hexToColor('#EDEAF0');

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
