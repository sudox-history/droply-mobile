import 'package:droply/common/aquarium/aquarium_state.dart';
import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'device_state.g.dart';

class DeviceState = _DeviceState with _$DeviceState;

abstract class _DeviceState with Store {
  @observable
  AquariumState progress = AquariumState();
  @observable
  String name;
  @observable
  int sentTime;
  @observable
  DeviceStatus status;
  @observable
  DeviceType type;

  @computed
  bool get needShowDots => status != DeviceStatus.IDLE;

  @computed
  IconData get icon {
    if (status == DeviceStatus.IDLE) {
      switch (type) {
        case DeviceType.DESKTOP:
          return Icons.desktop_mac;
        case DeviceType.IOS:
          return Icons.phone_iphone;
        case DeviceType.PHONE:
          return Icons.phone_android;
        case DeviceType.TABLET:
          return Icons.tablet;
        case DeviceType.UNKNOWN:
          return Icons.child_care;
      }
    } else if (status == DeviceStatus.RECEIVING) {
      return Icons.file_download;
    } else if (status == DeviceStatus.SENDING) {
      return Icons.publish;
    }

    return null;
  }

  @computed
  Color get iconColor {
    if (status != DeviceStatus.IDLE) {
      return AppColors.processColor;
    } else {
      return AppColors.accentColor;
    }
  }

  @computed
  Color get liquidColor {
    if (status != DeviceStatus.IDLE) {
      return AppColors.lightProcessColor;
    } else {
      return AppColors.lightAccentColor;
    }
  }

  @computed
  Color get descriptionColor {
    if (status != DeviceStatus.IDLE) {
      return AppColors.processColor;
    } else {
      return AppColors.secondaryTextColor;
    }
  }

  @computed
  Color get backgroundColor {
    if (status != DeviceStatus.IDLE) {
      return AppColors.lightenProcessColor;
    } else {
      return AppColors.lightenAccentColor;
    }
  }

  @computed
  String get description {
    switch (status) {
      case DeviceStatus.RECEIVING:
          return "Receiving";
      case DeviceStatus.SENDING:
          return "Sending";
      case DeviceStatus.IDLE:
          return "Sent at 13:00 PM";
    }

    return null;
  }
}

enum DeviceStatus { RECEIVING, SENDING, IDLE }
enum DeviceType { PHONE, IOS, TABLET, DESKTOP, UNKNOWN }