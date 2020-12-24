import 'entry_info.dart';

class FileInfo extends EntryInfo {
  FileInfo({
    String id,
    String name,
    EntryStatus status,
    int downloadedBytes,
    int summaryBytes,
  }) : super(
          id: id,
          name: name,
          status: status,
          downloadedBytes: downloadedBytes,
          summaryBytes: summaryBytes,
        );

  String get extension {
    var extension = name.split('.');
    extension.removeAt(0);
    return extension.join();
  }
}
