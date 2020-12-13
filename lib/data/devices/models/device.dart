class Device {
  final String id;
  final String name;
  final double progress;
  final DeviceType type;
  final DeviceStatus status;
  final int sentTime;

  Device({
    this.id,
    this.name,
    this.progress,
    this.type,
    this.status,
    this.sentTime,
  });
}

enum DeviceType { IPHONE, TABLET, DESKTOP, UNKNOWN, PHONE }
enum DeviceStatus { IDLE, RECEIVING, SENDING }