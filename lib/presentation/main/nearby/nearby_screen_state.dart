import 'package:droply/presentation/common/device/device_state.dart';
import 'package:flutter/foundation.dart';

abstract class NearbyScreenBlocState {}

class NearbyScreenScanningState implements NearbyScreenBlocState {
  Iterable<DeviceState> devicesStates;

  NearbyScreenScanningState({
    @required this.devicesStates,
  });
}

class NearbyScreenIdleState implements NearbyScreenBlocState {}

class NearbyScreenLoadingState implements NearbyScreenBlocState {}
