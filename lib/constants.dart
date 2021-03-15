import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const primaryIconsColor = Colors.black;
  static const primaryTextColor = Colors.black;
  static const secondaryTextColor = Color(0xFF808080);
  static const backgroundColor = Colors.white;
  static const hintTextColor = Color(0xFFBDBDBD);
  static const rippleEffectColor = Color(0x0D000000);
  static const highlightButtonColor = Color(0x05000000);

  static const lightenHintTextColor = Color(0xFFEDEDED);
  static const lightenAccentColor = Color(0xFFF3FAFF);
  static const lightAccentColor = Color(0xFFE8F4FC);
  static const accentColor = Color(0xFF2196F3);
  static const lightenBlackColor = Color(0xFFEFEFEF);

  static const onAccentColor = Colors.white;
  static const onSurfaceColor = Color(0xFF424242);
  static const onBackgroundColor = Color(0xFFF7F7F7);

  static const dividerColor = Color(0xFFE0E0E0);
  static const processColor = Color(0xFF18BFA5);
  static const lightProcessColor = Color(0xFFD2F4EF);
  static const lightenProcessColor = Color(0xFFF2FCFB);

  static const invariantPrimaryTextColor = Color(0xFF464646);
}

class AppFonts {
  static const openSans = "OpenSans";
  static const circe = "Circe";
  static const regular = FontWeight.w400;
  static const semibold = FontWeight.w600;
  static const bold = FontWeight.w700;
}

class AppRegex {
  static final deviceNameAllow = RegExp(r"^[a-zA-Zа-яА-Я0-9*-.!]{2,25}$");
}

class AppNavigation {
  static const authRouteName = "/auth";
  static const mainRouteName = "/main";
  static const settingsRouteName = "/main/settings";
  static const statisticsRouteName = "/main/statistics";
}

class AppOther {
  static const int maxInt =
      (double.infinity is int) ? double.infinity as int : ~minInt;
  static const int minInt =
      (double.infinity is int) ? -double.infinity as int : (-1 << 63);
}
