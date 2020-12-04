import 'package:droply/constants.dart';
import 'package:droply/presentation/common/my_device.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                MyDevice(),
                SizedBox(width: 20),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    MyDeviceAdditions.buildNameHint(),
                    MyDeviceAdditions.buildNameField(null, true),
                  ],
                ))
              ],
            ),
            SizedBox(height: 20),
            buildSwitchSetting("Calm mode",
                "Other users can see your profile via Internet or LAN"),
            SizedBox(height: 20),
            buildSwitchSetting(
                "Ping me", "Other users can notify me to open the EasyShare"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Black list",
                    style: TextStyle(
                      color: AppColors.onSurfaceColor,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.regular,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  "8 users",
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
