import 'dart:async';

import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/presentation/main/network/network_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkScreenBloc extends Bloc<List<Device>, NetworkScreenBlocState> {
  DevicesRepository devicesRepository;
  StreamSubscription _subscription;

  NetworkScreenBloc({DevicesRepository devicesRepository})
      : super(NetworkScreenLoadingState()) {
    add(null);

    _subscription = devicesRepository.getDevices().listen((devices) {
      add(devices);
    });
  }

  @override
  Stream<NetworkScreenBlocState> mapEventToState(devices) async* {
    if (devices != null) {
      yield NetworkScreenCompleteState(devices: devices);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }
}
