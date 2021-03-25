import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/helpers/animated_list_helper.dart';
import 'package:droply/presentation/common/device/device_widget.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_bloc.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Device> _devicesStates;

  @override
  Widget build(BuildContext context) {
    final DevicesRepository repository = RepositoryProvider.of<DevicesRepository>(context);

    return BlocProvider(
      create: (context) => NearbyScreenBloc(devicesRepository: repository),
      child: BlocConsumer<NearbyScreenBloc, NearbyScreenBlocState>(
        buildWhen: (previous, current) =>
            (previous is NearbyScreenLoadingState && current is! NearbyScreenScanningState) ||
            previous is! NearbyScreenLoadingState && current is NearbyScreenScanningState,
        listenWhen: (previous, current) {
          if (previous is! NearbyScreenScanningState && current is NearbyScreenScanningState) {
            _listKey.currentState.insertItem(1, duration: const Duration(milliseconds: 400));
          } else if (previous is NearbyScreenScanningState && current is! NearbyScreenScanningState) {
            setDevices(null);
            _listKey.currentState.removeItem(
              1,
              (_, animation) => _buildItem(1, animation, _devicesStates),
              duration: const Duration(milliseconds: 200),
            );
          }

          if (current is NearbyScreenScanningState) {
            setDevices(current.devices);
          }

          return false;
        },
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NearbyScreenLoadingState) {
            return buildScreenLoader();
          } else {
            return AnimatedList(
              key: _listKey,
              padding: const EdgeInsets.only(top: 20),
              initialItemCount: 1,
              itemBuilder: (context, position, animation) {
                return _buildItem(position, animation, _devicesStates);
              },
            );
          }
        },
      ),
    );
  }

  void setDevices(List<Device> states) {
    final oldStates = _devicesStates;
    _devicesStates = states;

    AnimatedListHelper.changeItems<Device, String>(
      offset: 2,
      insertDuration: const Duration(milliseconds: 400),
      removeDuration: const Duration(milliseconds: 200),
      state: _listKey.currentState,
      oldList: oldStates,
      newList: states,
      buildRemovedWidget: (context, animation, items, position) => _buildItem(position, animation, items),
      getId: (state) => state.id,
    );
  }

  Widget _buildItem(int position, Animation<double> animation, List<Device> items) {
    Widget widget;

    if (position == 0) {
      widget = _buildScanNearbyOption(context);
    } else if (position == 1) {
      widget = _buildScanningHint();
    } else {
      Device device;

      if (items != null) {
        device = items.elementAt(position - 2);
      } else {
        device = _devicesStates.elementAt(position - 2);
      }

      widget = DeviceWidget(initialState: device);
    }

    return FadeTransition(
      opacity: animation,
      child: widget,
    );
  }

  Widget _buildScanNearbyOption(BuildContext context) {
    return BlocBuilder<NearbyScreenBloc, NearbyScreenBlocState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildSwitchSetting(
            header: "Scan devices nearby",
            hint: "We'll show you devices that also use EasyShare",
            isChecked: state is NearbyScreenScanningState,
            callback: (checked) {
              BlocProvider.of<NearbyScreenBloc>(context).toggleListening(toggle: checked);
            },
          ),
        );
      },
    );
  }

  Widget _buildScanningHint() {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 12.5, left: 16, right: 16),
      child: Text(
        "Scanning for more devices ...",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.hintTextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 17,
        ),
      ),
    );
  }
}
