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

  bool _isCancelled = false;
  Timer _timer;

  @action
  void toggleScanning() {
    isScanningEnabled = !isScanningEnabled;

    if (isScanningEnabled) {
      _isCancelled = false;

      Future.delayed(Duration(seconds: 3)).then((value) {
        if (!_isCancelled) {
          var first = DeviceState();
          first.name = "Nikita Phone";
          first.type = DeviceType.PHONE;
          first.status = DeviceStatus.RECEIVING;
          deviceStates = [first];

          _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
            first.progress.upProgress();
          });
        }
      });
    } else {
      deviceStates = null;
      _isCancelled = true;

      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
    }
  }
}
