import 'dart:async';

import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/presentation/common/device/device_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceBloc extends Bloc<Device, DeviceState> {
  StreamSubscription _subscription;
  final DevicesRepository repository;
  final String id;

  DeviceBloc({
    @required this.id,
    @required DeviceState initialState,
    @required this.repository,
  }) : super(initialState) {
    _subscription = repository.getDevice(id).listen((device) {
      add(device);
    });
  }

  @override
  Stream<DeviceState> mapEventToState(device) async* {
    DeviceState state;

    if (device.status.index == DeviceStatus.IDLE.index) {
      state = IdleDeviceState(
        name: device.name,
        type: device.type,
        sentTime: device.sentTime,
      );
    } else if (device.status.index == DeviceStatus.RECEIVING.index ||
        device.status.index == DeviceStatus.SENDING.index) {
      state = WorkingDeviceState(
        name: device.name,
        progress: device.progress,
        status: device.status,
        type: device.type,
      );
    }

    yield state;
  }

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }
}
