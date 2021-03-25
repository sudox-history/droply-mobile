import 'package:droply/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSwitchSetting({
  String header,
  String hint,
  bool isChecked = false,
  void Function(bool) callback,
}) {
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
              style: const TextStyle(
                color: AppColors.onSurfaceColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.regular,
                fontSize: 17,
              ),
            ),
            Text(
              hint,
              style: const TextStyle(
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

Widget buildScreenLoader() {
  return const Center(
    child: SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(),
    ),
  );
}
