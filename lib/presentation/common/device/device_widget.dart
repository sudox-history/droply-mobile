import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/presentation/common/aquarium/aquarium.dart';
import 'package:droply/presentation/common/device/device_bloc.dart';
import 'package:droply/presentation/common/device/device_helper.dart';
import 'package:droply/presentation/common/device/device_state.dart';
import 'package:droply/presentation/common/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceWidget extends StatefulWidget {
  final Device initialState;

  const DeviceWidget({
    this.initialState,
  });

  @override
  State<StatefulWidget> createState() => DeviceWidgetState();
}

class DeviceWidgetState extends State<DeviceWidget> {
  final GlobalKey<AquariumState> _aquariumKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final DevicesRepository repository = RepositoryProvider.of<DevicesRepository>(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppNavigation.statisticsRouteName,
        arguments: widget.initialState.id,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 7.5,
          bottom: 7.5,
          left: 16,
        ),
        child: BlocProvider(
          create: (context) => DeviceBloc(
            initialState: widget.initialState,
            repository: repository,
          ),
          child: Row(
            children: [
              BlocConsumer<DeviceBloc, DeviceState>(
                buildWhen: (state, context) => false,
                builder: (context, state) {
                  return Aquarium(
                    key: _aquariumKey,
                    doneIcon: Icons.done_rounded,
                    idleIcon: DeviceHelper.getIcon(state.type),
                  );
                },
                listener: (context, state) {
                  if (state is WorkingDeviceState) {
                    if (state.status.index == DeviceStatus.receiving.index) {
                      _aquariumKey.currentState.progressIcon = Icons.download_rounded;
                    } else if (state.status.index == DeviceStatus.sending.index) {
                      _aquariumKey.currentState.progressIcon = Icons.publish_rounded;
                    }

                    _aquariumKey.currentState.setProgress(state.progress);
                  } else if (state is IdleDeviceState) {
                    _aquariumKey.currentState.setIdle();
                  }
                },
              ),
              const SizedBox(width: 15),
              Expanded(
                child: BlocBuilder<DeviceBloc, DeviceState>(
                  builder: (context, state) {
                    Color color;

                    if (state is WorkingDeviceState) {
                      color = AppColors.processColor;
                    } else if (state is IdleDeviceState) {
                      color = AppColors.hintTextColor;
                    }

                    Widget widget;
                    final TextStyle style = TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.semibold,
                      fontSize: 15,
                      color: color,
                    );

                    if (state is WorkingDeviceState) {
                      String description;

                      if (state.status == DeviceStatus.receiving) {
                        description = "Receiving";
                      } else if (state.status == DeviceStatus.sending) {
                        description = "Sending";
                      }

                      widget = Row(
                        children: [
                          Text(
                            description,
                            style: style,
                          ),
                          const SizedBox(width: 5),
                          const LoadingDots(AppColors.processColor)
                        ],
                      );
                    } else if (state is IdleDeviceState) {
                      // TODO: Time formatting
                      widget = Text(
                        "Sent at 3:30 PM",
                        style: style,
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.name,
                          style: const TextStyle(
                            color: AppColors.onSurfaceColor,
                            fontFamily: AppFonts.openSans,
                            fontWeight: AppFonts.semibold,
                            fontSize: 17,
                          ),
                        ),
                        widget,
                      ],
                    );
                  },
                ),
              ),
              IconButton(
                padding: const EdgeInsets.all(20),
                color: AppColors.onSurfaceColor,
                icon: const Icon(Icons.more_vert),
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
