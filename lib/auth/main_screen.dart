import 'package:droply/widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("app_name".tr(),
              style: TextStyle(
                  color: AppColors.headerTextColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.bold,
                  fontSize: 18)),
          centerTitle: true,
          bottom: AppWidgets.buildTabBar([
            AppWidgets.buildTab("Nearby"),
            AppWidgets.buildTab("Network")
          ]),
        ),
      ),
    );
  }
}
