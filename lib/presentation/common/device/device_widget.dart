import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/models/device.dart';
import 'package:droply/presentation/common/aquarium/aquarium.dart';
import 'package:droply/presentation/common/device/device_bloc.dart';
import 'package:droply/presentation/common/device/device_state.dart';
import 'package:droply/presentation/common/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceWidget extends StatefulWidget {
  final String id;
  final DeviceState initialState;

  DeviceWidget({this.id, this.initialState});

  @override
  State<StatefulWidget> createState() => DeviceWidgetState();
}

class DeviceWidgetState extends State<DeviceWidget> {
  final GlobalKey<AquariumState> _aquariumKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DevicesRepository repository =
        RepositoryProvider.of<DevicesRepository>(context);

    return Padding(
      child: BlocProvider(
        create: (context) => DeviceBloc(
          id: widget.id,
          initialState: widget.initialState,
          repository: repository,
        ),
        child: Row(
          children: [
            Container(
              child: BlocConsumer<DeviceBloc, DeviceState>(
                builder: (context, state) {
                  IconData idleIcon;

                  switch (state.type) {
                    case DeviceType.DESKTOP:
                      idleIcon = Icons.desktop_windows_rounded;
                      break;
                    case DeviceType.IPHONE:
                      idleIcon = Icons.phone_iphone_rounded;
                      break;
                    case DeviceType.TABLET:
                      idleIcon = Icons.tablet_rounded;
                      break;
                    case DeviceType.UNKNOWN:
                      idleIcon = Icons.question_answer_rounded;
                      break;
                    case DeviceType.PHONE:
                      idleIcon = Icons.phone_android_rounded;
                      break;
                  }

                  return Aquarium(
                    key: _aquariumKey,
                    doneIcon: Icons.done_rounded,
                    idleIcon: idleIcon,
                  );
                },
                listener: (context, state) {
                  if (state is WorkingDeviceState) {
                    if (state.status.index == DeviceStatus.RECEIVING.index) {
                      _aquariumKey.currentState.progressIcon =
                          Icons.download_rounded;
                    } else if (state.status.index ==
                        DeviceStatus.SENDING.index) {
                      _aquariumKey.currentState.progressIcon =
                          Icons.publish_rounded;
                    }

                    _aquariumKey.currentState.progress = state.progress;
                  } else if (state is IdleDeviceState) {
                    _aquariumKey.currentState.onLoadingDone();
                  }
                },
              ),
            ),
            SizedBox(width: 15),
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
                  TextStyle style = TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.semibold,
                    fontSize: 15,
                    color: color,
                  );

                  if (state is WorkingDeviceState) {
                    String description;

                    if (state.status == DeviceStatus.RECEIVING) {
                      description = "Receiving";
                    } else if (state.status == DeviceStatus.SENDING) {
                      description = "Sending";
                    }

                    widget = Row(
                      children: [
                        Text(
                          description,
                          style: style,
                        ),
                        SizedBox(width: 5),
                        LoadingDots(AppColors.processColor)
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
                        style: TextStyle(
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
              padding: EdgeInsets.all(20),
              color: AppColors.onSurfaceColor,
              icon: Icon(Icons.more_vert),
              onPressed: () => {},
            )
          ],
        ),
      ),
      padding: EdgeInsets.only(
        top: 7.5,
        bottom: 7.5,
        left: 16,
      ),
    );
  }
}

// import 'package:droply/common/aquarium/aquarium.dart';
// import 'package:droply/common/constants.dart';
// import 'package:droply/common/device/device_state.dart';
// import 'package:droply/common/ui/loading_dots.dart';
// import 'package:flutter/material.dart';
//
// class DeviceWidget extends StatelessWidget {
//   final Function _buttonCallback;
//   final DeviceState _state;
//
//   DeviceWidget(this._buttonCallback, this._state);
//
//   @override
//   Widget build(BuildContext context) {
//     // return Observer(builder: (_) {
// var descriptionBlock = <Widget>[
//   Text(
//     _state.description,
//     style: TextStyle(
//       color: _state.descriptionColor,
//       fontFamily: AppFonts.openSans,
//       fontWeight: AppFonts.semibold,
//       fontSize: 15,
//     ),
//   ),
// ];
//     //
//     //   if (_state.showDots) {
//     //     descriptionBlock.add(SizedBox(width: 5));
//     //     descriptionBlock.add(LoadingDots(AppColors.processColor));
//     //   }
//     //
//     //   var children = [
//     //     Container(
//     //       child: Aquarium(
//     //         _state.aquariumState,
//     //       ),
//     //     ),
//     //     Expanded(
//     //       child: Container(
//     //         margin: EdgeInsets.only(left: 15),
//     //         child: Column(
//     //           crossAxisAlignment: CrossAxisAlignment.start,
//     //           children: [
//     //             Text(
//     //               _state.name,
//     //               style: TextStyle(
//     //                 color: AppColors.onSurfaceColor,
//     //                 fontFamily: AppFonts.openSans,
//     //                 fontWeight: AppFonts.semibold,
//     //                 fontSize: 17,
//     //               ),
//     //             ),
//     //             SizedBox(height: 5),
//     //             Row(
//     //               crossAxisAlignment: CrossAxisAlignment.center,
//     //               children: descriptionBlock,
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     )
//     //   ];
//     //
//     //   var rightPadding = 16.0;
//     //
//     //   if (_buttonCallback != null) {
//     //     children.add(IconButton(
//     //       padding: EdgeInsets.all(20),
//     //       color: AppColors.onSurfaceColor,
//     //       icon: Icon(Icons.more_vert),
//     //       onPressed: _buttonCallback,
//     //     ));
//     //
//     //     rightPadding = 0;
//     //   }
//     //
//   return Padding(
//     child: Row(children: children),
//     padding: EdgeInsets.only(
//       top: 7.5,
//       bottom: 7.5,
//       right: rightPadding,
//       left: 16,
//     ),
//   );
// });
//   }
// }
