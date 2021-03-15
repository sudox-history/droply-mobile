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

enum DeviceType { ANDROID, IOS, DESKTOP, MAC, UNDEFINED }
enum DeviceStatus { IDLE, RECEIVING, SENDING }
