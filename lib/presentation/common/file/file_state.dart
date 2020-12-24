import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:flutter/foundation.dart';

abstract class FileState {
  final String id;
  final String name;
  final int summaryBytes;
  final String extension;

  FileState(this.id, this.name, this.summaryBytes, this.extension);

  factory FileState.fromFileInfo(FileInfo fileInfo) {
    FileState state;

    if (fileInfo.status == EntryStatus.COMPLETED) {
      state = CompletedFileState(
        id: fileInfo.id,
        name: fileInfo.name,
        summaryBytes: fileInfo.summaryBytes,
        extension: fileInfo.extension,
        compeletedTime: fileInfo.completedTime,
      );
    } else {
      state = LoadingFileState(
        id: fileInfo.id,
        name: fileInfo.name,
        summaryBytes: fileInfo.summaryBytes,
        status: fileInfo.status,
        extension: fileInfo.extension,
        progress: fileInfo.progress,
        downloadedBytes: fileInfo.downloadedBytes,
      );
    }

    return state;
  }
}

class CompletedFileState extends FileState {
  final int compeletedTime;

  CompletedFileState(
      {@required String id,
      @required String name,
      @required int summaryBytes,
      @required String extension,
      @required this.compeletedTime})
      : super(id, name, summaryBytes, extension);
}

class LoadingFileState extends FileState {
  final EntryStatus status;
  final double progress;
  final int downloadedBytes;

  LoadingFileState({
    @required String id,
    @required String name,
    @required String extension,
    @required int summaryBytes,
    @required this.status,
    @required this.progress,
    @required this.downloadedBytes,
  }) : super(id, name, summaryBytes, extension);
}
