import 'package:droply/constants.dart';
import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/helpers/animated_list_helper.dart';
import 'package:droply/presentation/common/file/file_widget.dart';
import 'package:droply/presentation/common/folder/folder_widget.dart';
import 'package:droply/presentation/statistics/statistics_screen_bloc.dart';
import 'package:droply/presentation/statistics/statistics_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticsScreen extends StatelessWidget {
  List<EntryInfo> _entriesInfo;
  GlobalKey<AnimatedListState> _listKey;

  @override
  Widget build(BuildContext context) {
    var entriesRepository = RepositoryProvider.of<EntriesRepository>(context);

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
      body: BlocProvider(
        create: (context) => StatisticsScreenBloc(
          deviceId: "1",
          entriesRepository: entriesRepository,
        ),
        child: BlocConsumer<StatisticsScreenBloc, StatisticsScreenState>(
          listenWhen: (previous, current) {},
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedList(
              key: _listKey,
              initialItemCount: 3,
              itemBuilder: (context, position, animation) =>
                  _buildItem(context, animation, _entriesInfo, position),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(context, animation, items, position) {
    if (position == 0) {
      return _buildListHeader("Statistics");
    } else if (position == 1) {
      return _buildProgressBlock();
    } else if (position == 2) {
      return _buildListHeader("Active loadings");
    }

    var entry = items[position - 3];

    if (entry is FolderInfo) {
      return FolderWidget(initialState: entry);
    } else if (entry is FileInfo) {
      return FileWidget(initialState: entry);
    }
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
          backgroundColor: AppColors.lightenAccentColor,
          progressColor: AppColors.accentColor,
          circularStrokeCap: CircularStrokeCap.round,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.file_download,
                color: AppColors.accentColor,
              ),
              SizedBox(height: 1),
              Text(
                "0 Mb",
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 1),
              Text(
                "0 Gb",
                style: TextStyle(
                  color: AppColors.accentColor,
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
        color: AppColors.lightenAccentColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.accentColor,
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
              color: AppColors.accentColor,
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
