import 'dart:async';

import 'package:droply/common/aquarium/aquarium_state.dart';
import 'package:droply/common/device/device_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
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
  Timer _timer2;

  @action
  void toggleScanning() {
    isScanningEnabled = !isScanningEnabled;

    if (isScanningEnabled) {
      _isCancelled = false;

      Future.delayed(Duration(seconds: 1)).then((value) {
        if (!_isCancelled) {
          var progress = 0.0;
          var progress2 = 0.0;

          var first = DeviceState();
          first.name = "Nikita Phone";
          first.aquariumState = AquariumState();
          first.dateTime = DateFormat("hh:mm on EEEE").format(DateTime.now());

          first.aquariumState.deviceIcon = Icons.phone_android_rounded;
          first.aquariumState.loadingIcon = Icons.download_rounded;

          var second = DeviceState();
          second.name = "Yaroslav Dekstop";
          second.aquariumState = AquariumState();
          second.dateTime = DateFormat("hh:mm on EEEE").format(DateTime.now());

          second.aquariumState.deviceIcon = Icons.desktop_mac_rounded;
          second.aquariumState.loadingIcon = Icons.publish_rounded;

          var third = DeviceState();
          third.name = "Test";
          third.aquariumState = AquariumState();
          third.dateTime = DateFormat("hh:mm on EEEE").format(DateTime.now());
          third.aquariumState.deviceIcon = Icons.desktop_mac_rounded;
          third.aquariumState.loadingIcon = Icons.publish_rounded;

          deviceStates = [first, second, third];

          Future.delayed(Duration(seconds: 1)).then((value) => {
                first.deviceStatus = DeviceStatus.RECEIVING,
                _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
                  progress += 0.01;
                  first.aquariumState.setProgress(progress);
                  if (progress >= 1.0) {
                    first.deviceStatus = DeviceStatus.IDLE;
                    _timer.cancel();
                  }
                }),
              });

          Future.delayed(Duration(seconds: 10)).then((value) => {
                progress = 0,
                first.deviceStatus = DeviceStatus.SENDING,
                first.aquariumState.loadingIcon = Icons.publish_rounded,
                _timer = Timer.periodic(Duration(milliseconds: 60), (timer) {
                  progress += 0.01;
                  first.aquariumState.setProgress(progress);
                  if (progress >= 1.0) {
                    first.deviceStatus = DeviceStatus.IDLE;
                    _timer.cancel();
                  }
                }),
              });

          Future.delayed(Duration(seconds: 2)).then((value) => {
                second.deviceStatus = DeviceStatus.SENDING,
                _timer2 = Timer.periodic(Duration(milliseconds: 60), (timer) {
                  progress2 += 0.005;
                  second.aquariumState.setProgress(progress2);
                  if (progress2 >= 1.0) {
                    second.deviceStatus = DeviceStatus.IDLE;
                  }
                }),
              });
        }
      });
    } else {
      deviceStates = null;
      _isCancelled = true;

      if (_timer != null) {
        _timer.cancel();
        _timer2.cancel();
        _timer = null;
        _timer2 = null;
      }
    }
  }
}
