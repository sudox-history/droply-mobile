import 'dart:async';

import 'package:droply/common/device/device_state.dart';
import 'package:mobx/mobx.dart';

part 'nearby_screen_state.g.dart';

class NearbyScreenState = _NearbyScreenState with _$NearbyScreenState;

abstract class _NearbyScreenState with Store {
  @observable
  bool isScanningEnabled = false;
  @observable
  List<DeviceState> deviceStates;

  @action
  void toggleScanning() {
    isScanningEnabled = !isScanningEnabled;

    if (isScanningEnabled) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        var first = DeviceState();
        first.name = "Nikita Phone";
        first.type = DeviceType.PHONE;
        first.status = DeviceStatus.RECEIVING;
        deviceStates = [first];

        Timer.periodic(Duration(milliseconds: 50), (timer) {
          first.progress.upProgress();
        });
      });
    } else {
      deviceStates = null;
    }
  }
}
