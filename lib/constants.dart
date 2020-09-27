import 'package:flutter/material.dart';

class AppColors {
  static final primaryIconsColor = Colors.black;
  static final headerTextColor = Colors.black;
  static final whiteColor = Colors.white;
  static final labelTextColor = Color(0xFF424242);
  static final hint1TextColor = Color(0xFF808080);
  static final hint2TextColor = Color(0xFFBDBDBD);

  static final lightBlue = Color(0xFFE8F4FC);
  static final blue = Color(0xFF2196F3);
}

class AppFonts {
  static final openSans = "OpenSans";
  static final regular = FontWeight.w400;
  static final semibold = FontWeight.w600;
  static final bold = FontWeight.w700;
}

class Regex {
  static final deviceNameAllow = RegExp(r"^[a-zA-Zа-яА-Я0-9*-.!]{2,25}$");
}