import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {
  final String id;

  DeviceWidget({this.id});

  @override
  Widget build(BuildContext context) {
    // TODO: Move to bloc

    String description;

    switch ()

    var descriptionBlock = <Widget>[
      Text(
        _state.description,
        style: TextStyle(
          color: _state.descriptionColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.semibold,
          fontSize: 15,
        ),
      ),
    ];
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
//       var descriptionBlock = <Widget>[
//         Text(
//           _state.description,
//           style: TextStyle(
//             color: _state.descriptionColor,
//             fontFamily: AppFonts.openSans,
//             fontWeight: AppFonts.semibold,
//             fontSize: 15,
//           ),
//         ),
//       ];
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
//     //   return Padding(
//     //     child: Row(children: children),
//     //     padding: EdgeInsets.only(
//     //       top: 7.5,
//     //       bottom: 7.5,
//     //       right: rightPadding,
//     //       left: 16,
//     //     ),
//     //   );
//     // });
//   }
// }
