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
    if (type == DeviceType.ANDROID) {
      return Icons.phone_android_rounded;
    } else if (type == DeviceType.IOS) {
      return Icons.phone_iphone_rounded;
    } else if (type == DeviceType.DESKTOP) {
      return Icons.desktop_windows_rounded;
    } else if (type == DeviceType.MAC) {
      return Icons.desktop_mac_rounded;
    } else {
      return Icons.contact_support_rounded;
    }
  }
}
