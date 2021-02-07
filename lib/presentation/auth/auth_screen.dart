import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 60),
        child: Column(
          children: [
            _buildWelcomeTitle(),
            _buildWelcomeHint(),
            Expanded(child: Container()),
            _buildAuthButtons(),
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

  Widget _buildAuthButtons() {
    return Column(
      children: [
        _buildGoogleSignIn(),
        SizedBox(height: 16),
        _buildAppleSignIn(),
        SizedBox(height: 15),
        _buildLicenseText(),
      ],
    );
  }

  Widget _buildGoogleSignIn() {
    return InkWell(
      onTap: () =>_handleSignIn(),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Ink(
          padding: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
            color: AppColors.lightAccentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/google-icon.svg", width: 20),
              SizedBox(width: 15),
              Text(
                "Sign in by Google",
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.semibold,
                  fontSize: 16,
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

  Widget _buildAppleSignIn() {
    return InkWell(
      onTap: () {},
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Ink(
          padding: EdgeInsets.only(top: 14, bottom: 14),
          decoration: BoxDecoration(
            color: AppColors.lightenBlackColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/apple-icon.svg", width: 20),
              SizedBox(width: 15),
              Text(
                "Sign in by Apple",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.semibold,
                  fontSize: 16,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildLicenseText() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.regular,
            fontSize: 15,
          ),
          children: [
            TextSpan(text: "agreement1".tr()),
            TextSpan(
              text: "agreement2".tr(),
              style: TextStyle(
                color: AppColors.accentColor,
                fontWeight: AppFonts.semibold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  const url = "https://flutter.io";
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}
