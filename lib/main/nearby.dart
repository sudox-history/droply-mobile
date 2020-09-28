import 'package:droply/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NearbyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NearbyScreenState();
  }
}

class _NearbyScreenState extends State<NearbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [_buildScanSection()],
          )),
    );
  }

  Widget _buildScanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Scan devices nearby",
              style: TextStyle(
                color: AppColors.labelTextColor,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              ),
            ),
            Switch(

              value: true,
              onChanged: (bool state) {},

            )
          ],
        ),
        Text(
          "We'll show you devices that also use EasyShare",
          style: TextStyle(
            color: AppColors.hint2TextColor,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.regular,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
