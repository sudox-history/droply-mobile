import 'dart:async';

import 'package:droply/common/aquarium/aquarium.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearbyScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {

  final GlobalKey<AquariumState> key = GlobalKey();

  NearbyScreenState() {
    double progress = 0;

    Timer.periodic(Duration(seconds: 1), (_) {
      key.currentState.progress = progress;
      progress += 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Aquarium(
      key: key,
      doneIcon: Icons.done,
      processIcon: Icons.download_sharp,
      idleIcon: Icons.phone_android,
    );
  }
}

// import 'package:droply/common/constants.dart';
// import 'package:droply/common/device/device_widget.dart';
// import 'package:droply/common/ui/other_widgets.dart';
// import 'package:droply/main/nearby/nearby_screen_state.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
//
// class NearbyScreen extends StatelessWidget {
//   final NearbyScreenState _state = NearbyScreenState();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Observer(
//         builder: (_) {
//           var children = <Widget>[
//             SizedBox(height: 20),
//             _buildScanNearbyOption(),
//           ];
//
//           if (_state.isScanningEnabled) {
//             children.add(_buildScanningHint());
//           }
//
//           if (_state.deviceStates != null) {
//             children.addAll(_state.deviceStates.map((state) {
//               return DeviceWidget((){}, state);
//             }));
//           }
//
//           return ListView(children: children);
//         },
//       ),
//     );
//   }
//
//   Padding _buildScanNearbyOption() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: buildSwitchSetting(
//         "Scan devices nearby",
//         "We'll show you devices that also use EasyShare",
//         _state.isScanningEnabled,
//         (checked) {
//           _state.toggleScanning();
//         },
//       ),
//     );
//   }
//
//   Widget _buildScanningHint() {
//     return Padding(
//       padding: EdgeInsets.only(top: 20, bottom: 12.5, left: 16, right: 16),
//       child: Text(
//         "Scanning for more devices ...",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: AppColors.hintTextColor,
//           fontFamily: AppFonts.openSans,
//           fontWeight: AppFonts.regular,
//           fontSize: 17,
//         ),
//       ),
//     );
//   }
// }
