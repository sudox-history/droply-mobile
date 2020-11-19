import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

Widget buildSwitchSetting(String header, String hint, [bool isChecked = false, callback]) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
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
                fontWeight: AppFonts.regular,
                fontSize: 17,
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
        alignment: Alignment.topRight,
        child: CupertinoSwitch(
          activeColor: AppColors.accentColor,
          value: isChecked,
          onChanged: callback,
        ),
      )
    ],
  );
}
