import 'package:droply/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            _buildIdBlock(),
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
              color: AppColors.hint1TextColor,
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
                color: AppColors.blue,
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
                          color: AppColors.blue,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.regular,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "(Click to copy)",
                        style: TextStyle(
                          color: AppColors.hint2TextColor,
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
                  color: AppColors.blue,
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
