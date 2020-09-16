import 'dart:io';
import 'package:droply/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:device_info/device_info.dart';

import 'main_screen.dart';

final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo androidDeviceInfo;
IosDeviceInfo iOSDeviceInfo;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _buttonEnabled = false;

  void _changeButtonEnabled(bool enable) {
    setState(() {
      _buttonEnabled = enable;
    });
  }

  String model = "phone_box".tr();

  void getDeviceInfo() async {
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        model = androidDeviceInfo.model;
      });
    } else if (Platform.isIOS) {
      iOSDeviceInfo = await deviceInfo.iosInfo;
      setState(() {
        model = iOSDeviceInfo.model;
      });
    }
  }

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 20),
            child: Column(children: [
              _buildWelcomeTitle(),
              SizedBox(height: 16),
              _buildWelcomeHint(),
              SizedBox(height: 50),
              Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_android, color: AppColors.blue),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(model,
                            style: TextStyle(
                                color: AppColors.blue,
                                fontFamily: AppFonts.openSans,
                                fontWeight: AppFonts.semibold,
                                fontSize: 16)),
                      )
                    ],
                  )),
              SizedBox(height: 15),
              _buildDeviceNameHint(),
              TextField(
                  style: TextStyle(
                    color: AppColors.labelTextColor,
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 20,
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  onChanged: (text) {
                    _changeButtonEnabled(Regex.deviceNameAllow.hasMatch(text));
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "enter_device_name_hint".tr(),
                    hintStyle: TextStyle(
                      color: AppColors.hint2TextColor,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.regular,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(height: 50),
              FlatButton(
                color: AppColors.blue,
                disabledColor: AppColors.hint2TextColor,
                padding: EdgeInsets.only(left: 100, right: 100, top: 14, bottom: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: _buttonEnabled
                    ? () {
                        //TODO: backend auth
                        Route route = MaterialPageRoute(builder: (context) => MainScreen());
                        Navigator.pushReplacement(context, route);
                      }
                    : null,
                child: Text(
                  "enter_button".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.semibold,
                      fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              _buildLicenseText()
            ]),
          )),
    );
  }
}

Widget _buildWelcomeTitle() {
  return Text(
    "welcome_title".tr(),
    style: TextStyle(
        color: AppColors.headerTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20),
  );
}

Widget _buildWelcomeHint() {
  return Text(
    "welcome_hint".tr(),
    textAlign: TextAlign.center,
    style: TextStyle(
        color: AppColors.hint1TextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.regular,
        fontSize: 18),
  );
}

Widget _buildDeviceNameHint() {
  return Text(
    "device_name_hint".tr(),
    textAlign: TextAlign.center,
    style: TextStyle(
        color: AppColors.hint1TextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.semibold,
        fontSize: 16),
  );
}

Widget _buildLicenseText() {
  return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
              color: AppColors.hint1TextColor,
              fontFamily: AppFonts.openSans,
              fontWeight: AppFonts.regular,
              fontSize: 15),
          children: [
            TextSpan(text: "agreement1".tr()),
            TextSpan(
                text: "agreement2".tr(),
                style: TextStyle(color: AppColors.blue, fontWeight: AppFonts.semibold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    const url = "https://flutter.io";
                    if (await canLaunch(url)) launch(url);
                  }),
          ],
        ),
      ));
}
