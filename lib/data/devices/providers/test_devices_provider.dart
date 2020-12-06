import 'package:droply/data/devices/models/device.dart';
import 'package:droply/data/devices/providers/devices_provider.dart';
import 'package:droply/presentation/common/device/device_state.dart';

class TestDevicesProvider implements DevicesProvider {
  Stream<Device> _secondDevice = Stream.value(Device(
    name: "Max's tablet",
    type: DeviceType.TABLET,
    status: DeviceStatus.IDLE,
    sentTime: 1607107316000,
  ));

  Stream<Device> _thirdDevice = Stream.value(Device(
    name: "Yaroslav's desktop",
    type: DeviceType.DESKTOP,
    status: DeviceStatus.IDLE,
    sentTime: 1607107826000,
  ));

  Stream<Device> _fourthDevice = Stream.value(Device(
    name: "Uno",
    type: DeviceType.UNKNOWN,
    status: DeviceStatus.IDLE,
    sentTime: 1607107862000,
  ));

  Stream<Device> _fifthDevice = Stream.value(Device(
    name: "Alexey's phone",
    type: DeviceType.PHONE,
    status: DeviceStatus.IDLE,
    sentTime: 1607108002000,
  ));

  @override
  Stream<Device> getDevice(String id) {
    switch (id) {
      case "1":
        return Stream.periodic(Duration(milliseconds: 250), (count) {
          DeviceStatus status;
          double progress = (count + 1) / 20;

          if (progress >= 1.0) {
            status = DeviceStatus.IDLE;
          } else {
            status = DeviceStatus.SENDING;
          }

          return Device(
            name: "Anton's iPhone",
            progress: progress,
            type: DeviceType.IPHONE,
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
    return Stream.fromFuture(Future(() {
      return [
        Device(
          name: "Anton's iPhone",
          progress: 0,
          type: DeviceType.IPHONE,
          status: DeviceStatus.IDLE,
          sentTime: 100,
        )
      ];
    }));
  }
}
