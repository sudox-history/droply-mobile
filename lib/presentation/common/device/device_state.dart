import 'package:droply/data/devices/models/device.dart';
import 'package:flutter/foundation.dart';

abstract class DeviceState {
  final String name;
  final DeviceType type;

  DeviceState(this.name, this.type);

  factory DeviceState.fromDevice(Device device) {
    DeviceState state;

    if (device.status.index == DeviceStatus.IDLE.index) {
      state = IdleDeviceState(
        name: device.name,
        type: device.type,
        sentTime: device.sentTime,
      );
    } else if (device.status.index == DeviceStatus.RECEIVING.index ||
        device.status.index == DeviceStatus.SENDING.index) {
      state = WorkingDeviceState(
        name: device.name,
        progress: device.progress,
        status: device.status,
        type: device.type,
      );
    }

    return state;
  }
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
