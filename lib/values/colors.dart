import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors{
  static final Color MAIN_COLOR = HexColor("#6C63FF");
  static final Color LIGHT_MAIN_COLOR = HexColor("#ABA6FF");
  static final Color LIGHT_RED_COLOR = HexColor("#FF6044");
  static final Color BACK_WHITE_COLOR = Colors.white;
  static final Color LIGHT_DIVIDER_COLOR = Colors.grey[400];
  static final Color BACK_LIGHT_GREY = Colors.grey[200];

  static final Color ICON_LIGHT_COLOR = Colors.grey[600];

  static final Color SHIMMER_DARK_COLOR = Colors.grey[300];
  static final Color SHIMMER_LIGHT_COLOR = Colors.white;

  static final Color TEXT_WHITE = Colors.white;
}

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