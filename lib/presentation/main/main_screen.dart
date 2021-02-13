import 'package:droply/presentation/bottom_bars/new_request_bar.dart';
import 'package:droply/presentation/common/toolbar_title/toolbar_title.dart';
import 'package:droply/presentation/main/nearby/nearby_screen.dart';
import 'package:droply/presentation/main/network/network_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: ToolbarTitle("app_name".tr()),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigator.pushNamed(context, AppNavigation.settingsRouteName);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => NewRequestWidget(),
                );
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
