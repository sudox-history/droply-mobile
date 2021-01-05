import 'dart:async';

import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/presentation/common/file/file_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileBloc extends Bloc<FileInfo, FileState> {
  StreamSubscription _subscription;
  final EntriesRepository repository;

  FileBloc({
    @required FileInfo initialState,
    @required this.repository,
  }) : super(FileState.fromFileInfo(initialState)) {
    _subscription = repository.getFile(initialState.id).listen((fileInfo) {
      add(fileInfo);
    });

    add(initialState);
  }

  @override
  Stream<FileState> mapEventToState(FileInfo fileInfo) =>
      Stream.value(FileState.fromFileInfo(fileInfo));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
