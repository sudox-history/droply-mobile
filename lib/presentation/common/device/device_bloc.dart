import 'package:droply/presentation/common/device/device_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceBloc extends Bloc<dynamic, DeviceState> {
  DeviceBloc({@required DeviceState initialState}) : super(initialState);

  @override
  Stream<DeviceState> mapEventToState(event) async* {
    throw Error();
  }
}
