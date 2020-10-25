import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyPhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My phone"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.publish),
        label: Text(
          "Send",
          style: TextStyle(
            color: AppColors.onAccentColor,
            fontWeight: AppFonts.semibold,
            fontFamily: AppFonts.openSans,
            letterSpacing: 0,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListHeader("Statistics"),
          _buildProgressBlock(),
          _buildListHeader("History"),
        ],
      ),
    );
  }

  Widget _buildListHeader(String text) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildProgressBlock() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 15),
      child: Row(
        children: [
          _buildProgressContainer(),
          SizedBox(width: 28),
          _buildProgressTimeBlock(),
        ],
      ),
    );
  }

  Widget _buildProgressContainer() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CircularPercentIndicator(
          radius: 140,
          lineWidth: 15,
          backgroundColor: AppColors.onBackgroundColor,
          progressColor: AppColors.accentColor,
          circularStrokeCap: CircularStrokeCap.round,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.file_download,
                color: AppColors.secondaryTextColor,
              ),
              SizedBox(height: 1),
              Text(
                "0 Mb",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 1),
              Text(
                "0 Gb",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.regular,
                  fontSize: 14,
                ),
              )
            ],
          ),
          percent: 0.4,
        ),
      ],
    );
  }

  Widget _buildProgressTimeBlock() {
    return Expanded(
      child: Column(
        children: [
          _buildProgressInfoBlock("0 Mb/s", "Download speed"),
          SizedBox(height: 10),
          _buildProgressInfoBlock("0 minutes", "Estimated time"),
        ],
      ),
    );
  }

  Widget _buildProgressInfoBlock(String info, String name) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 14, bottom: 14, right: 30),
      decoration: BoxDecoration(
        color: AppColors.onBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontWeight: AppFonts.bold,
              fontFamily: AppFonts.openSans,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 1),
          Text(
            name,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontWeight: AppFonts.regular,
              fontFamily: AppFonts.openSans,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
