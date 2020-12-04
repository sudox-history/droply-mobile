import 'package:droply/data/devices/models/device.dart';

abstract class DevicesProvider {
  Stream<Device> getDevice(String id);
}
