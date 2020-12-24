import 'entry_info.dart';

class FolderInfo extends EntryInfo {
  final int downloadedFiles;
  final int filesCount;

  FolderInfo({
    String id,
    String name,
    EntryStatus status,
    int downloadedBytes,
    int summaryBytes,
    this.downloadedFiles,
    this.filesCount,
  }) : super(
          id: id,
          name: name,
          status: status,
          downloadedBytes: downloadedBytes,
          summaryBytes: summaryBytes,
        );
}
