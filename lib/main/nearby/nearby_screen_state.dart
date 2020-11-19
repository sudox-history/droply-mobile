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
          var second = DeviceState();
          second.name = "Alexander PC";
          second.type = DeviceType.DESKTOP;
          second.status = DeviceStatus.IDLE;
          second.sentTime = 0;
          var third = DeviceState();
          third.name = "Yaroslav Phone";
          third.type = DeviceType.PHONE;
          third.status = DeviceStatus.IDLE;
          third.sentTime = 0;
          var fourth = DeviceState();
          fourth.name = "Maxim Tablet";
          fourth.type = DeviceType.TABLET;
          fourth.status = DeviceStatus.IDLE;
          fourth.sentTime = 0;
          var fifth = DeviceState();
          fifth.name = "Anton iPhone";
          fifth.type = DeviceType.IOS;
          fifth.status = DeviceStatus.IDLE;
          fifth.sentTime = 0;
          var sixth = DeviceState();
          sixth.name = "Unknown device";
          sixth.type = DeviceType.UNKNOWN;
          sixth.status = DeviceStatus.IDLE;
          sixth.sentTime = 0;

          deviceStates = [first, second, third, fourth, fifth, sixth];

          _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
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
