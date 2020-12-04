import 'package:droply/data/devices/models/device.dart';
import 'package:flutter/foundation.dart';

abstract class DeviceState {
  final String name;
  final DeviceType type;

  DeviceState(this.name, this.type);
}

class WorkingDeviceState extends DeviceState {
  final double progress;
  final DeviceStatus status;

  WorkingDeviceState({
    @required String name,
    @required DeviceType type,
    @required this.progress,
    @required this.status,
  }) : super(name, type);
}

class IdleDeviceState extends DeviceState {
  final int sentTime;

  IdleDeviceState({
    @required String name,
    @required DeviceType type,
    @required this.sentTime,
  }) : super(name, type);
}
