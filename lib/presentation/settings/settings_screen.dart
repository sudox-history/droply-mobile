import 'package:droply/constants.dart';
import 'package:droply/presentation/common/device/my_device/my_device.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 75, height: 75, child: const MyDevice()),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 5),
                      buildNameHint(),
                      buildNameField(null, true),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            buildSwitchSetting("Calm mode",
                "Other users can see your profile via Internet or LAN"),
            const SizedBox(height: 20),
            buildSwitchSetting(
                "Ping me", "Other users can notify me to open the EasyShare"),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "Black list",
                    style: const TextStyle(
                      color: AppColors.onSurfaceColor,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.regular,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Text(
                  "8 users",
                  style: const TextStyle(
                    color: AppColors.accentColor,
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildNameHint() {
    return Text(
      "device_name_hint".tr(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.secondaryTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.semibold,
        fontSize: 16,
      ),
    );
  }

  static Widget buildNameField([
    Function onChanged(bool isValid),
    bool hintAtStart = false,
    bool initialText,
  ]) {
    return TextField(
      style: const TextStyle(
        color: AppColors.onSurfaceColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(25)],
      onChanged: (text) {
        onChanged?.call(AppRegex.deviceNameAllow.hasMatch(text));
      },
      textAlign: hintAtStart ? TextAlign.start : TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        hintText: "enter_device_name_hint".tr(),
        hintStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 20,
        ),
        isDense: true,
      ),
    );
  }
}
