import 'package:droply/common/ui/my_device.dart';
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
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    MyDeviceAdditions.buildNameHint(),
                    MyDeviceAdditions.buildNameField(null, true),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
