import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:droply/presentation/common/device/device_helper.dart';
import 'package:droply/presentation/common/device/my_device/my_device_event.dart';
import 'package:droply/presentation/common/device/my_device/my_device_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

class MyDeviceBloc extends Bloc<MyDeviceEvent, MyDeviceState> {
  MyDeviceBloc() : super(MyDeviceLoadingState()) {
    _load();
  }

  void _load() async {
    String name = "Undefined";

    if (Platform.isAndroid) {
      name = (await _plugin.androidInfo).model;
    } else if (Platform.isIOS) {
      name = (await _plugin.iosInfo).model;
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      name = "Desktop";
    }

    add(MyDeviceLoadedEvent(
      name: name,
      icon: DeviceHelper.getCurrentDeviceIcon(),
    ));
  }

  @override
  Stream<MyDeviceState> mapEventToState(event) async* {
    if (event is MyDeviceLoadedEvent) {
      yield MyDeviceLoadedState(
        name: event.name,
        icon: event.icon,
      );
    }
  }
}
