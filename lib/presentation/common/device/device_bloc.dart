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
    @required Device initialState,
    @required this.repository,
  }) : super(DeviceState.fromDevice(initialState)) {
    _subscription = repository.getDevice(id).listen((device) {
      add(device);
    });

    // Хуй под названием listener не получает начальное состояние
    // Этот костыль заставляет его делать
    add(initialState);
  }

  @override
  Stream<DeviceState> mapEventToState(device) =>
      Stream.value(DeviceState.fromDevice(device));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
