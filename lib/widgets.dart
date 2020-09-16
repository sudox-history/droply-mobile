import 'package:droply/constants.dart';
import 'package:flutter/material.dart';

class AppWidgets {
  static AppBar buildAppBar() {}

  static Tab buildTab(String title) {
    return Tab(child: Text(
      title,
      style: TextStyle(
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.semibold,
        fontSize: 15,
      ),
    ));
  }

  static TabBar buildTabBar(List<Tab> tabs) {
    return TabBar(isScrollable: true, tabs: tabs);
  }
}
