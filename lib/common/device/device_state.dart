import 'package:droply/common/aquarium/aquarium_state.dart';
import 'package:droply/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'device_state.g.dart';

class DeviceState = _DeviceState with _$DeviceState;

abstract class _DeviceState with Store {

  @observable
  AquariumState aquariumState;

  @observable
  String name;

  @observable
  DeviceStatus deviceStatus = DeviceStatus.IDLE;

  @observable
  String dateTime;

  @computed
  String get description {
    switch (deviceStatus) {
      case DeviceStatus.RECEIVING:
        return "Receiving";
        break;
      case DeviceStatus.SENDING:
        return "Sending";
        break;
      default:
        return "Sent at " + dateTime;
        break;
    }
  }

  @computed
  Color get descriptionColor => deviceStatus == DeviceStatus.IDLE
      ? AppColors.hintTextColor
      : AppColors.processColor;

  @computed
  bool get showDots => deviceStatus == DeviceStatus.IDLE ? false : true;
}

enum DeviceStatus { RECEIVING, SENDING, IDLE }
enum DeviceType { PHONE, TABLET, DESKTOP, UNKNOWN }
