import 'package:droply/data/devices/models/device.dart';
import 'package:droply/data/devices/providers/devices_provider.dart';

class TestDevicesProvider implements DevicesProvider {
  final Stream<Device> _secondDevice = Stream.value(Device(
    id: "2",
    name: "Max's tablet",
    type: DeviceType.ANDROID,
    status: DeviceStatus.IDLE,
    sentTime: 1607107316000,
  ));

  final Stream<Device> _thirdDevice = Stream.value(Device(
    id: "3",
    name: "Yaroslav's desktop",
    type: DeviceType.DESKTOP,
    status: DeviceStatus.IDLE,
    sentTime: 1607107826000,
  ));

  final Stream<Device> _fourthDevice = Stream.value(Device(
    id: "4",
    name: "Uno",
    type: DeviceType.UNDEFINED,
    status: DeviceStatus.IDLE,
    sentTime: 1607107862000,
  ));

  final Stream<Device> _fifthDevice = Stream.value(Device(
    id: "5",
    name: "Alexey's phone",
    type: DeviceType.ANDROID,
    status: DeviceStatus.IDLE,
    sentTime: 1607108002000,
  ));

  @override
  Stream<Device> getDevice(String id) {
    switch (id) {
      case "1":
        return Stream.periodic(const Duration(milliseconds: 50), (count) {
          DeviceStatus status;
          final double progress = (count + 1) / 100;

          if (progress >= 1.0) {
            status = DeviceStatus.IDLE;
          } else {
            status = DeviceStatus.SENDING;
          }

          return Device(
            name: "Anton's iPhone",
            progress: progress,
            type: DeviceType.IOS,
            status: status,
            sentTime: 100,
          );
        });
      case "2":
        return _secondDevice;
      case "3":
        return _thirdDevice;
      case "4":
        return _fourthDevice;
      case "5":
        return _fifthDevice;
    }

    return null;
  }

  @override
  Stream<List<Device>> getDevices() {
    return Stream.fromFuture(Future.delayed(const Duration(seconds: 1), () {
      return [
        Device(
          id: "1",
          name: "Anton's iPhone",
          progress: 0,
          type: DeviceType.IOS,
          status: DeviceStatus.IDLE,
          sentTime: 100,
        )
      ];
    }));
  }
}
