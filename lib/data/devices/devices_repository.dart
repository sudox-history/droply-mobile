import 'package:droply/data/devices/models/device.dart';
import 'package:droply/data/devices/providers/devices_provider.dart';
import 'package:flutter/foundation.dart';

class DevicesRepository {
  DevicesProvider provider;

  DevicesRepository({
    @required this.provider,
  });

  Stream<Device> getDevice(String id) {
    return provider.getDevice(id);
  }

  Stream<List<Device>> getDevices() {
    return provider.getDevices();
  }
}
