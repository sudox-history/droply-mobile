import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

Widget buildSwitchSetting(String header, String hint) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                color: AppColors.onSurfaceColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              ),
            ),
            Text(
              hint,
              style: TextStyle(
                color: AppColors.hintTextColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.regular,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          activeColor: AppColors.accentColor,
          value: true,
          onChanged: (bool state) {},
        ),
      )
    ],
  );
}
