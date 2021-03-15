import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class MyDeviceState {}

class MyDeviceLoadingState extends MyDeviceState {}

class MyDeviceLoadedState extends MyDeviceState {
  final String name;
  final IconData icon;

  MyDeviceLoadedState({
    @required this.name,
    @required this.icon,
  });
}
