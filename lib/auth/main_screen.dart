import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("app_name".tr(),
              style: TextStyle(
                  color: AppColors.headerTextColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.bold,
                  fontSize: 18)),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
    );
  }
}
