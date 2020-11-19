import 'package:droply/common/constants.dart';
import 'package:droply/common/ui/device_widget.dart';
import 'package:droply/common/ui/other_widgets.dart';
import 'package:droply/state/progress/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';


DeviceWidget widget = DeviceWidget(
    "Nikita Phone",
    "Sending",
    AppColors.processColor,
    AppColors.lightenProcessColor,
    AppColors.lightProcessColor,
    Icons.computer);

class NearbyScreen extends StatelessWidget {
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

            FlatButton.icon(onPressed: (){
              widget.progress.upProgress();
            }, icon: Icon(Icons.add), label: Text("Hello")),


            widget,

            DeviceWidget(
                "Max Desktop",
                "Sending",
                AppColors.processColor,
                AppColors.lightenProcessColor,
                AppColors.lightProcessColor,
                Icons.phone_android),
          ],
        ),
      ),
    );
  }
}
