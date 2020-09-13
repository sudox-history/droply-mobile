import 'package:droply/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.only(top: 56),
            child: Text("We are glad to see you here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.headerTextColor,
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.bold,
                    fontSize: 20))),
        Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              "Enter a name and upload some photo to easily find this device",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.hint1TextColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.regular,
                  fontSize: 18),
            )),
      ]),
    )));
  }
}
