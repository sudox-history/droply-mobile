import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/presentation/common/device/device_state.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyScreenBloc extends Bloc<bool, NearbyScreenBlocState> {
  DevicesRepository devicesRepository;

  NearbyScreenBloc({
    this.devicesRepository,
  }) : super(NearbyScreenLoadingState()) {
    add(false);
  }

  @override
  Stream<NearbyScreenBlocState> mapEventToState(bool toggle) {
    if (toggle) {
      return devicesRepository
          .getDevices()
          .map((devices) =>
              devices.map((device) => DeviceState.fromDevice(device)))
          .map((states) => NearbyScreenScanningState(devicesStates: states));
    } else {
      return Stream.value(NearbyScreenIdleState());
    }
  }
}
