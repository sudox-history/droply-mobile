import 'package:droply/common/constants.dart';
import 'package:droply/common/ui/device_widget.dart';
import 'package:droply/state/progress/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Progress progress1 = Progress();
Progress progress2 = Progress();

class NetworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            _buildIdBlock(),
            SizedBox(height: 22.5),
            FlatButton.icon(
              onPressed: () {
                progress1.upProgress();
              },
              icon: Icon(Icons.add),
              label: Text("ggg1"),
            ),
            FlatButton.icon(
              onPressed: () {
                progress2.upProgress();
              },
              icon: Icon(Icons.delete),
              label: Text("ggg2"),
            ),
            DeviceWidget(
              "Nikita Phone",
              "Sending",
              AppColors.processColor,
              AppColors.lightenProcessColor,
              AppColors.lightProcessColor,
              Icons.computer,
              null,
              progress1,
              true,
              () {},
              null,
            ),
            DeviceWidget(
              "Max Desktop",
              "Sending",
              AppColors.processColor,
              AppColors.lightenProcessColor,
              AppColors.lightProcessColor,
              Icons.phone_android,
              null,
              progress2,
              true,
              () {},
              null,
            ),
          ],
        ),
      ),
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
        )
      ],
    );
  }
}
