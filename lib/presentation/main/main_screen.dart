import 'package:droply/constants.dart';
import 'package:droply/presentation/common/toolbar_title/toolbar_title.dart';
import 'package:droply/presentation/main/nearby/nearby_screen.dart';
import 'package:droply/presentation/main/network/network_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool _) {
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
                      primary: true,
                      snap: false,
                      elevation: 0.5,
                      forceElevated: true,
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: "Nearby"),
                          Tab(text: "Network"),
                        ],
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.settings),
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
      ),
    );
  }
}
