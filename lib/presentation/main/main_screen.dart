import 'package:droply/constants.dart';
import 'package:droply/presentation/common/app_bar.dart';
import 'package:droply/presentation/common/toolbar_title/toolbar_title.dart';
import 'package:droply/presentation/main/nearby/nearby_screen.dart';
import 'package:droply/presentation/main/network/network_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: ToolbarTitle("app_name".tr()),
                    floating: true,
                    pinned: true,
                    elevation: AppBarStyles.elevation,
                    forceElevated: true,
                    bottom: const TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: "Nearby"),
                        Tab(text: "Network"),
                      ],
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppNavigation.settingsRouteName,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              NearbyScreen(),
              NetworkScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
