import 'package:droply/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
              _buildPhoneBox(),
              SizedBox(height: 15),
              _buildDeviceNameHint(),
              SizedBox(height: 5),
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
                    hintText: "enter device name",
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
                onPressed: _buttonEnabled ? () {} : null,
                child: Text(
                  "Start sharing",
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
    "We are glad to see you here!",
    style: TextStyle(
        color: AppColors.headerTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20),
  );
}

Widget _buildWelcomeHint() {
  return Text(
    "Enter a name and upload some photo to easily find this device",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: AppColors.hint1TextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.regular,
        fontSize: 18),
  );
}

Widget _buildPhoneBox() {
  return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
          color: AppColors.lightBlue, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone_android, color: AppColors.blue),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text("Phone",
                style: TextStyle(
                    color: AppColors.blue,
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.semibold,
                    fontSize: 16)),
          )
        ],
      ));
}

Widget _buildDeviceNameHint() {
  return Text(
    "Device name",
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
      padding: EdgeInsets.only(left: 40, right: 40),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
              color: AppColors.hint1TextColor,
              fontFamily: AppFonts.openSans,
              fontWeight: AppFonts.regular,
              fontSize: 16),
          children: [
            TextSpan(text: "By continuing you agree to our "),
            TextSpan(
                text: "Terms of service ",
                style: TextStyle(color: AppColors.blue, fontWeight: AppFonts.semibold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    const url = "https://flutter.io";
                    if (await canLaunch(url)) launch(url);
                  }),
            TextSpan(text: "and "),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(color: AppColors.blue, fontWeight: AppFonts.semibold),
            ),
          ],
        ),
      ));
}
