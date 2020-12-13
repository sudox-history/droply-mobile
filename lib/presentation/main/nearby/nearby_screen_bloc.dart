import 'dart:async';

import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyScreenBloc extends Bloc<List<Device>, NearbyScreenBlocState> {
  DevicesRepository devicesRepository;
  StreamSubscription _subscription;

  NearbyScreenBloc({
    this.devicesRepository,
  }) : super(NearbyScreenLoadingState()) {
    add(null);
  }

  void toggleListening(bool toggle) {
    if (toggle) {
      add([]);

      _subscription = devicesRepository.getDevices().listen((devices) {
        add(devices);
      });
    } else {
      _subscription?.cancel();
      _subscription = null;
      add(null);
    }
  }

  @override
  Stream<NearbyScreenBlocState> mapEventToState(devices) async* {
    if (devices != null) {
      yield NearbyScreenScanningState(devices: devices);
    } else {
      yield NearbyScreenIdleState();
    }
  }
}
