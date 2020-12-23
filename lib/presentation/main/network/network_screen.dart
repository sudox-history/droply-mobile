import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/helpers/animated_list_helper.dart';
import 'package:droply/presentation/common/device/device_widget.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_screen_bloc.dart';
import 'network_screen_state.dart';

class NetworkScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NetworkScreenState();
}

class NetworkScreenState extends State<NetworkScreen> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Iterable<Device> _devicesStates;

  @override
  Widget build(BuildContext context) {
    DevicesRepository repository =
        RepositoryProvider.of<DevicesRepository>(context);

    return BlocProvider(
      create: (context) => NetworkScreenBloc(devicesRepository: repository),
      child: BlocConsumer<NetworkScreenBloc, NetworkScreenBlocState>(
        buildWhen: (previous, current) => previous is NetworkScreenLoadingState && current is NetworkScreenCompleteState,
        listenWhen: (previous, current) => !(previous is NetworkScreenLoadingState) && !(current is NetworkScreenCompleteState),
        listener: (context, current) {
          if (current is NetworkScreenCompleteState) {
            _devices = current.devices;
          } else {
            _devices = null;
          }
        },
        builder: (context, state) {
          if (state is NetworkScreenLoadingState) {
            return buildScreenLoader();
          } else if (state is NetworkScreenCompleteState) {
            _devicesStates = state.devices;

            return AnimatedList(
              key: _listKey,
              padding: EdgeInsets.only(top: 20),
              initialItemCount: 1 + state.devices.length,
              itemBuilder: (context, position, animation) {
                return _buildItem(position, animation, _devicesStates);
              },
            );
          }

          return null;
        },
      ),
    );
  }

  set _devices(Iterable<Device> states) {
    var oldStates = _devicesStates;
    _devicesStates = states;

    AnimatedListHelper.changeItems<Device, String>(
      offset: 1,
      state: _listKey.currentState,
      oldList: oldStates,
      newList: states,
      buildRemovedWidget: (context, animation, items, position) =>
          _buildItem(position, animation, items),
      getId: (state) => state.id,
    );
  }

  Widget _buildItem(position, animation, items) {
    Widget widget;

    if (position == 0) {
      widget = _buildIdBlock();
    } else {
      Device device;

      if (items != null) {
        device = items.elementAt(position - 1);
      } else {
        device = _devicesStates.elementAt(position - 1);
      }

      widget = DeviceWidget(
        initialState: device,
      );
    }

    return FadeTransition(
      opacity: animation,
      child: widget,
    );
  }

  Widget _buildIdBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            "Your ID",
            style: TextStyle(
              fontFamily: AppFonts.openSans,
              fontWeight: AppFonts.semibold,
              color: AppColors.secondaryTextColor,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: Row(
            children: [
              Icon(
                Icons.content_copy,
                color: AppColors.accentColor,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "034-213-533",
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.regular,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "(Click to copy)",
                        style: TextStyle(
                          color: AppColors.hintTextColor,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.regular,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: AppColors.accentColor,
                ),
                padding: EdgeInsets.all(20),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
