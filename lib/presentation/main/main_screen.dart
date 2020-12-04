import 'package:droply/constants.dart';
import 'package:droply/presentation/main/nearby/nearby_screen.dart';
import 'package:droply/presentation/main/network_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("app_name".tr()),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, AppNavigation.settingsRouteName);
              },
            )
          ],
          bottom: TabBar(isScrollable: true, tabs: [
            Tab(text: "Nearby"),
            Tab(text: "Network"),
          ]),
        ),
        body: TabBarView(
          children: [
            NearbyScreen(),
            NetworkScreen(),
          ],
        ),
      ),
    );
  }
}