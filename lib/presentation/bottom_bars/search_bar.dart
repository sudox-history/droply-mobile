import 'package:droply/constants.dart';
import 'package:flutter/material.dart';
import 'package:droply/presentation/common/bottom_sheet_container.dart';
import 'package:droply/presentation/common/formatters/upper_case_formatter.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Fields count to const

    return BottomSheetContainer(
      headerBodyMargin: 30,
      bodyFooterMargin: 38,
      title: "Searching",
      description: "Enter ID of the recipient",
      body: PinPut(
        fieldsCount: 6,
        separatorPositions: const [3],
        eachFieldWidth: 45,
        eachFieldHeight: 45,
        pinAnimationType: PinAnimationType.scale,
        withCursor: true,
        autofocus: true,
        inputFormatters: [UpperCaseTextFormatter()],
        keyboardType: TextInputType.text,
        followingFieldDecoration: _createFieldDecoration(),
        selectedFieldDecoration: _createFieldDecoration(),
        submittedFieldDecoration: _createFieldDecoration(),
        textStyle: const TextStyle(
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.semibold,
          fontSize: 16,
          color: AppColors.invariantPrimaryTextColor,
        ),
        separator: Container(
          color: AppColors.dividerColor,
          height: 2,
          width: 8,
        ),
      ),
      footer: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: const Text("Search"),
          ),
        ),
      ]),
    );
  }

  BoxDecoration _createFieldDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: AppColors.dividerColor,
      ),
    );
  }
}
