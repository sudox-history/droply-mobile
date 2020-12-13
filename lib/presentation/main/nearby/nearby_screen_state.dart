import 'package:droply/data/devices/models/device.dart';
import 'package:flutter/foundation.dart';

abstract class NearbyScreenBlocState {}

class NearbyScreenScanningState implements NearbyScreenBlocState {
  Iterable<Device> devices;

  NearbyScreenScanningState({
    @required this.devices,
  });
}

class NearbyScreenIdleState implements NearbyScreenBlocState {}

class NearbyScreenLoadingState implements NearbyScreenBlocState {}
