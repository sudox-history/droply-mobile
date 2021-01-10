import 'package:droply/constants.dart';
import 'package:droply/presentation/common/bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pin_put/pin_put.dart';

class NewRequestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      headerBodyMargin: 10,
      bodyFooterMargin: 30,
      title: "A new request",
      description: "Check if these numbers match on another device",
      body: null,//TODO: implement a body of the new request bottom sheet
      footer: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forbid",
              style: TextStyle(
                color: AppColors.accentColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.lightAccentColor),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text("Accept"),
          ),
        ),
      ]),
    );
  }
}
