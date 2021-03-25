import 'dart:io';

import 'package:droply/data/devices/models/device.dart';
import 'package:flutter/material.dart';

class DeviceHelper {
  static IconData getCurrentDeviceIcon() {
    if (Platform.isAndroid) {
      return Icons.phone_android_rounded;
    } else if (Platform.isIOS) {
      return Icons.phone_iphone_rounded;
    } else if (Platform.isWindows || Platform.isLinux) {
      return Icons.desktop_windows_rounded;
    } else if (Platform.isMacOS) {
      return Icons.desktop_mac_rounded;
    } else {
      return Icons.contact_support_rounded;
    }
  }

  static IconData getIcon(DeviceType type) {
    if (type == DeviceType.android) {
      return Icons.phone_android_rounded;
    } else if (type == DeviceType.ios) {
      return Icons.phone_iphone_rounded;
    } else if (type == DeviceType.desktop) {
      return Icons.desktop_windows_rounded;
    } else if (type == DeviceType.mac) {
      return Icons.desktop_mac_rounded;
    } else {
      return Icons.contact_support_rounded;
    }
  }
}
