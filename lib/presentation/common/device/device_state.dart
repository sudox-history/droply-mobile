abstract class DeviceState {
  final String name;

  DeviceState(this.name);
}

class WorkingDeviceState extends DeviceState {
  final double progress;

  WorkingDeviceState({String name, this.progress}) : super(name);
}

class IdleDeviceState extends DeviceState {
  final DeviceType type;
  final int sentTime;

  IdleDeviceState({String name, this.type, this.sentTime}) : super(name);
}

// TODO: Move to data
enum DeviceType { IPHONE, TABLET, DESKTOP, UNKNOWN, PHONE }
