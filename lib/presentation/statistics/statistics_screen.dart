import 'package:droply/constants.dart';
import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/presentation/common/file/file_widget.dart';
import 'package:droply/presentation/common/folder/folder_widget.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:droply/presentation/statistics/statistics_screen_bloc.dart';
import 'package:droply/presentation/statistics/statistics_screen_state.dart';
import 'package:droply/helpers/animated_list_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<EntryInfo> _activeLoadingsEntries;
  List<EntryInfo> _historyLoadingsEntries;
  GlobalKey<AnimatedListState> _listKey;
  bool _isHistoryHeaderInserted = false;
  bool _isActiveLoadingsHeaderInserted = false;

  @override
  Widget build(BuildContext context) {
    final entriesRepository = RepositoryProvider.of<EntriesRepository>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My phone")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.publish),
        label: const Text(
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
          listenWhen: (previous, current) {
            if (current is StatisticsScreenCompleteState) {
              final oldActiveLoadingsEntries = _activeLoadingsEntries;
              final oldHistoryLoadingsEntries = _historyLoadingsEntries;

              _activeLoadingsEntries = current.activeEntries;
              _historyLoadingsEntries = current.historyEntries;

              if (previous is! StatisticsScreenCompleteState) {
                return false;
              }

              if (current.activeEntries.isNotEmpty && !_isActiveLoadingsHeaderInserted) {
                _isActiveLoadingsHeaderInserted = true;
                _listKey.currentState.insertItem(2); // TODO: Change duration
              } else if (current.activeEntries.isEmpty && _isActiveLoadingsHeaderInserted) {
                _listKey.currentState.removeItem(
                  2,
                  (context, animation) => _buildItem(
                    context,
                    animation,
                    null,
                    2,
                  ),
                ); // TODO: Change duration

                _isActiveLoadingsHeaderInserted = false;
              }

              int activeLoadingsItemsOffset = 3;

              if (!_isActiveLoadingsHeaderInserted) {
                activeLoadingsItemsOffset--;
              }

              AnimatedListHelper.changeItems<EntryInfo, String>(
                getId: (info) => info.id,
                offset: activeLoadingsItemsOffset,
                state: _listKey.currentState,
                oldList: oldActiveLoadingsEntries,
                newList: current.activeEntries,
                buildRemovedWidget: _buildItem,
              );

              int historyHeaderPosition = 2;

              if (_isActiveLoadingsHeaderInserted) {
                historyHeaderPosition += 1 + current.activeEntries.length;
              }

              if (current.historyEntries.isNotEmpty && !_isHistoryHeaderInserted) {
                _isHistoryHeaderInserted = true;
                _listKey.currentState.insertItem(historyHeaderPosition);
              } else if (current.historyEntries.isEmpty && _isHistoryHeaderInserted) {
                _listKey.currentState.removeItem(
                  historyHeaderPosition,
                  (context, animation) => _buildItem(
                    context,
                    animation,
                    null,
                    historyHeaderPosition,
                  ),
                ); // TODO: Change duration

                _isHistoryHeaderInserted = false;
              }

              int historyLoadingsItemsOffset = historyHeaderPosition + 1;

              if (!_isHistoryHeaderInserted) {
                historyLoadingsItemsOffset--;
              }

              AnimatedListHelper.changeItems<EntryInfo, String>(
                offset: historyLoadingsItemsOffset,
                state: _listKey.currentState,
                oldList: oldHistoryLoadingsEntries,
                newList: current.historyEntries,
                buildRemovedWidget: _buildItem,
                getId: (info) => info.id,
              );
            }

            return false;
          },
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous is StatisticsScreenLoadingState && current is StatisticsScreenCompleteState,
          builder: (context, state) {
            if (state is StatisticsScreenCompleteState) {
              int initialCount = 2;

              _isActiveLoadingsHeaderInserted = state.activeEntries.isNotEmpty;
              _isHistoryHeaderInserted = state.historyEntries.isNotEmpty;
              _historyLoadingsEntries = state.historyEntries;
              _activeLoadingsEntries = state.activeEntries;

              if (_isActiveLoadingsHeaderInserted) {
                initialCount += 1 + _activeLoadingsEntries.length;
              }

              if (_isHistoryHeaderInserted) {
                initialCount += 1 + _historyLoadingsEntries.length;
              }

              return AnimatedList(
                key: _listKey,
                initialItemCount: initialCount,
                itemBuilder: (context, position, animation) => _buildItem(context, animation, null, position),
              );
            } else {
              return buildScreenLoader();
            }
          },
        ),
      ),
    );
  }

  Widget _buildItem(context, animation, List<EntryInfo> items, int position) {
    if (position == 0) {
      return _buildListHeader("Statistics");
    } else if (position == 1) {
      return _buildProgressBlock();
    }

    if (items == null) {
      if (position == 2) {
        if (_isActiveLoadingsHeaderInserted) {
          return _buildListHeader("Active loadings");
        } else if (_isHistoryHeaderInserted) {
          return _buildListHeader("History");
        }
      } else if (_isActiveLoadingsHeaderInserted && position == 3 + _activeLoadingsEntries.length) {
        return _buildListHeader("History");
      } else if (_isActiveLoadingsHeaderInserted && _isHistoryHeaderInserted) {
        if (2 + _activeLoadingsEntries.length < position) {
          return _buildListEntry(_historyLoadingsEntries[position - _activeLoadingsEntries.length - 4]);
        } else {
          return _buildListEntry(_activeLoadingsEntries[position - 3]);
        }
      } else if (_isActiveLoadingsHeaderInserted && !_isHistoryHeaderInserted) {
        return _buildListEntry(_activeLoadingsEntries[position - 3]);
      } else {
        return _buildListEntry(_historyLoadingsEntries[position - 3]);
      }
    } else {
      return _buildListEntry(items[position]);
    }

    throw UnsupportedError("Unsupported case");
  }

  Widget _buildListEntry(EntryInfo entry) {
    if (entry is FolderInfo) {
      return FolderWidget(initialState: entry);
    } else if (entry is FileInfo) {
      return FileWidget(initialState: entry);
    }

    return null;
  }

  Widget _buildListHeader(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Text(
        text,
        style: const TextStyle(
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
      margin: const EdgeInsets.only(left: 16, right: 16, top: 15),
      child: Row(
        children: [
          _buildProgressContainer(),
          const SizedBox(width: 28),
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
            children: const [
              Icon(Icons.file_download, color: AppColors.accentColor),
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
          const SizedBox(height: 10),
          _buildProgressInfoBlock("0 minutes", "Estimated time"),
        ],
      ),
    );
  }

  Widget _buildProgressInfoBlock(String info, String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 14, bottom: 14, right: 30),
      decoration: const BoxDecoration(
        color: AppColors.lightenAccentColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info,
            maxLines: 1,
            style: const TextStyle(
              color: AppColors.accentColor,
              fontWeight: AppFonts.bold,
              fontFamily: AppFonts.openSans,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            name,
            maxLines: 1,
            style: const TextStyle(
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
