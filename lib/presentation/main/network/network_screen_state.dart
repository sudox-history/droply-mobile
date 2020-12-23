import 'package:droply/data/devices/models/device.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkScreenBlocState {}

class NetworkScreenCompleteState implements NetworkScreenBlocState {
  Iterable<Device> devices;

  NetworkScreenCompleteState({
    @required this.devices,
  });
}

class NetworkScreenLoadingState implements NetworkScreenBlocState {}
