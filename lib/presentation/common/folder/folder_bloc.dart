import 'dart:async';
import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/presentation/common/folder/folder_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderBloc extends Bloc<FolderInfo, FolderState> {
  StreamSubscription _subscription;
  final EntriesRepository repository;

  FolderBloc({
    @required FolderInfo initialState,
    @required this.repository,
  }) : super(FolderState.fromFolderInfo(initialState)) {
    _subscription = repository.getFolder(initialState.id).listen((folderInfo) {
      add(folderInfo);
    });

    add(initialState);
  }

  @override
  Stream<FolderState> mapEventToState(FolderInfo folderInfo) =>
      Stream.value(FolderState.fromFolderInfo(folderInfo));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
