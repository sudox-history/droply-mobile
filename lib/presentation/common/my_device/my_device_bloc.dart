import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:droply/presentation/common/my_device/my_device_event.dart';
import 'package:droply/presentation/common/my_device/my_device_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

class MyDeviceBloc extends Bloc<MyDeviceEvent, MyDeviceState> {
  MyDeviceBloc() : super(MyDeviceLoadingState()) {
    _load();
  }

  void _load() async {
    if (Platform.isAndroid) {
      var info = await _plugin.androidInfo;
    } else if (Platform.isIOS) {
      var info = await _plugin.iosInfo;
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      // Desktop
    }
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
