import 'package:droply/constants.dart';
import 'package:droply/presentation/auth/auth_screen_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AuthScreenLayout(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildWelcomeTitle(),
                _buildWelcomeHint(),
              ],
            ),
            _buildAuthButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTitle() {
    return Text(
      "welcome_title".tr(),
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildWelcomeHint() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        "welcome_hint".tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
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
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildGoogleSignIn(),
        const SizedBox(height: 16),
        _buildAppleSignIn(),
        const SizedBox(height: 15),
        _buildLicenseText(),
      ],
    );
  }

  Widget _buildGoogleSignIn() {
    return InkWell(
      onTap: () => _handleSignIn(),
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Ink(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        decoration: const BoxDecoration(
          color: AppColors.lightAccentColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/google-icon.svg", width: 20),
            const SizedBox(width: 15),
            const Text(
              "Sign in by Google",
              style: TextStyle(
                color: AppColors.accentColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      // TODO: Handle
    }
  }

  Widget _buildAppleSignIn() {
    return InkWell(
      onTap: () {},
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Ink(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        decoration: const BoxDecoration(
          color: AppColors.lightenBlackColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/apple-icon.svg", width: 20),
            const SizedBox(width: 15),
            const Text(
              "Sign in by Apple",
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.regular,
            fontSize: 15,
          ),
          children: [
            TextSpan(text: "agreement1".tr()),
            TextSpan(
              text: "agreement2".tr(),
              style: const TextStyle(
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
