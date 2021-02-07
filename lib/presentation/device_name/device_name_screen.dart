import 'package:droply/constants.dart';
import 'package:droply/presentation/common/my_device.dart';
import 'package:droply/presentation/device_name/device_name_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeviceNameScreenState();
}

class _DeviceNameScreenState extends State<DeviceNameScreen> {
  var _canStart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DeviceNameScreenLayout(
          children: [
            Column(
              children: [
                _buildWelcomeTitle(),
                _buildWelcomeHint(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyDevice(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: MyDeviceAdditions.buildNameHint(),
                ),
                MyDeviceAdditions.buildNameField((allow) {
                  setState(() {
                    _canStart = allow;
                  });
                }),
              ],
            ),
            Column(
              children: [
                _buildStartSharingButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTitle() {
    return Text(
      "welcome_title".tr(),
      style: TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildWelcomeHint() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "welcome_hint".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.secondaryTextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 18,
        ),
      ),
    );
  }
  
  Widget _buildStartSharingButton() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      width: double.infinity,
      child: TextButton(
        onPressed: _canStart ? _onStartSharingButtonClicked : null,
        child: Text("enter_button".tr()),
      ),
    );
  }

  void _onStartSharingButtonClicked() {
    Navigator.pushReplacementNamed(context, AppNavigation.mainRouteName);
  }
}
