import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/models/folder_info.dart';
import 'package:flutter/foundation.dart';

abstract class FolderState {
  final String id;
  final String name;
  final int summaryBytes;
  final int downloadedFiles;
  final int filesCount;

  FolderState(this.id, this.name, this.summaryBytes, this.downloadedFiles,
      this.filesCount);

  factory FolderState.fromFolderInfo(FolderInfo folderInfo) {
    FolderState state;

    if (folderInfo.status == EntryStatus.COMPLETED) {
      state = CompletedFolderState(
        id: folderInfo.id,
        name: folderInfo.name,
        summaryBytes: folderInfo.summaryBytes,
        downloadedFiles: folderInfo.downloadedFiles,
        filesCount: folderInfo.filesCount,
        compeletedTime: folderInfo.completedTime,
      );
    } else {
      state = LoadingFolderState(
        id: folderInfo.id,
        name: folderInfo.name,
        summaryBytes: folderInfo.summaryBytes,
        downloadedFiles: folderInfo.downloadedFiles,
        filesCount: folderInfo.filesCount,
        status: folderInfo.status,
        progress: folderInfo.progress,
        downloadedBytes: folderInfo.downloadedBytes,
      );
    }

    return state;
  }
}

class CompletedFolderState extends FolderState {
  final int compeletedTime;

  CompletedFolderState({
    @required String id,
    @required String name,
    @required int summaryBytes,
    @required int downloadedFiles,
    @required int filesCount,
    @required this.compeletedTime,
  }) : super(id, name, summaryBytes, downloadedFiles, filesCount);
}

class LoadingFolderState extends FolderState {
  final EntryStatus status;
  final double progress;
  final int downloadedBytes;

  LoadingFolderState({
    @required String id,
    @required String name,
    @required int summaryBytes,
    @required int downloadedFiles,
    @required int filesCount,
    @required this.status,
    @required this.progress,
    @required this.downloadedBytes,
  }) : super(id, name, summaryBytes, downloadedBytes, filesCount);
}
