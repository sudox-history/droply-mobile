import 'package:flutter/material.dart';

class AppWidgets {
  static TabBar buildTabBar(List<Tab> tabs) {
    return TabBar(isScrollable: true, tabs: tabs);
  }
}
