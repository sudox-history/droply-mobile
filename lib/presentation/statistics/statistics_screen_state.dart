import 'package:droply/data/entries/models/entry_info.dart';
import 'package:flutter/foundation.dart';

abstract class StatisticsScreenState {}

class StatisticsScreenLoadingState implements StatisticsScreenState {}

class StatisticsScreenCompleteState implements StatisticsScreenState {
  final List<EntryInfo> entries;

  StatisticsScreenCompleteState({
    @required this.entries,
  });
}
