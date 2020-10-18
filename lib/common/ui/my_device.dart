import 'package:easy_localization/easy_localization.dart';
import 'package:device_info/device_info.dart';
import 'package:droply/common/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  var _deviceModel;
  var _isAndroid;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  void _getDeviceInfo() async {
    var info = DeviceInfoPlugin();
    var model;

    if (Platform.isAndroid) {
      _isAndroid = true;
      model = (await info.androidInfo).model;
    } else if (Platform.isIOS) {
      _isAndroid = false;
      model = (await info.iosInfo).model;
    }

    setState(() {
      _deviceModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: AppColors.lightAccentColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _deviceModel != null ? _buildDeviceInfo() : _buildProgress(),
      ),
    );
  }

  List<Widget> _buildDeviceInfo() => [
        Icon(
          _isAndroid ? Icons.phone_android : Icons.phone_iphone,
          color: AppColors.accentColor,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Text(
            _deviceModel,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.accentColor,
              fontFamily: AppFonts.openSans,
              fontWeight: AppFonts.semibold,
              fontSize: 16,
            ),
          ),
        )
      ];

  List<Widget> _buildProgress() => [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ];
}

class MyDeviceAdditions {
  static Widget buildNameHint() {
    return Text(
      "device_name_hint".tr(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.secondaryTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.semibold,
        fontSize: 16,
      ),
    );
  }

  static Widget buildNameField([Function onChanged, bool hintAtStart = false, bool initialText]) {
    return TextField(
      style: TextStyle(
        color: AppColors.onSurfaceColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(25)],
      onChanged: (text) {
        onChanged(AppRegex.deviceNameAllow.hasMatch(text));
      },
      textAlign: hintAtStart ? TextAlign.start : TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        hintText: "enter_device_name_hint".tr(),
        hintStyle: TextStyle(
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
