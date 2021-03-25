import 'dart:async';

import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/presentation/statistics/statistics_screen_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';

class StatisticsScreenBloc extends Bloc<List<List<EntryInfo>>, StatisticsScreenState> {
  StreamSubscription _streamSubscription;

  StatisticsScreenBloc({
    @required String deviceId,
    @required EntriesRepository entriesRepository,
  }) : super(StatisticsScreenLoadingState()) {
    _streamSubscription =
        StreamZip([entriesRepository.getActiveEntries(deviceId), entriesRepository.getHistoryEntries(deviceId)])
            .listen(add);
  }

  @override
  Stream<StatisticsScreenState> mapEventToState(List<List<EntryInfo>> entries) =>
      Stream.value(StatisticsScreenCompleteState(
        activeEntries: entries[0],
        historyEntries: entries[1],
      ));

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }
}
