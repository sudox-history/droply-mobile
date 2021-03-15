import 'package:flutter/cupertino.dart';

abstract class MyDeviceEvent {}

class MyDeviceLoadedEvent extends MyDeviceEvent {
  final String name;
  final IconData icon;

  MyDeviceLoadedEvent({
    @required this.name,
    @required this.icon,
  });
}
