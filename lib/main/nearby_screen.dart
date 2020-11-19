import 'package:droply/common/constants.dart';
import 'package:droply/common/ui/device_widget.dart';
import 'package:droply/common/ui/other_widgets.dart';
import 'package:droply/state/progress/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class NearbyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NearbyScreenState();
  }
}

Progress progress1 = Progress();
Progress progress2 = Progress();

class _NearbyScreenState extends State<NearbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            buildSwitchSetting(
                "Scan devices nearby",
                "We'll show you devices that also use "
                    "EasyShare"),
            FlatButton.icon(
              onPressed: () {
                progress1.upProgress();
              },
              icon: Icon(Icons.add),
              label: Text("ggg"),
            ),
            FlatButton.icon(
              onPressed: () {
                progress2.upProgress();
              },
              icon: Icon(Icons.delete),
              label: Text("ggg"),
            ),
            DeviceWidget(
              "Nikita Phone",
              "Sending",
              AppColors.processColor,
              AppColors.lightenProcessColor,
              AppColors.lightProcessColor,
              Icons.computer,
              null,
              progress1,
              true,
              null,
              null
            ),
            DeviceWidget(
              "Max Desktop",
              "Sending",
              AppColors.processColor,
              AppColors.lightenProcessColor,
              AppColors.lightProcessColor,
              Icons.phone_android,
              null,
              progress2,
              true,
              null,
              null
            ),
          ],
        ),
      ),
    );
  }
}
