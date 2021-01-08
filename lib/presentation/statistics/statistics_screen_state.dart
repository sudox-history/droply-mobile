import 'package:droply/data/entries/models/entry_info.dart';
import 'package:flutter/foundation.dart';

abstract class StatisticsScreenState {}

class StatisticsScreenLoadingState implements StatisticsScreenState {}

class StatisticsScreenCompleteState implements StatisticsScreenState {
  final List<EntryInfo> activeEntries;
  final List<EntryInfo> historyEntries;

  StatisticsScreenCompleteState({
    @required this.activeEntries,
    @required this.historyEntries,
  });
}
