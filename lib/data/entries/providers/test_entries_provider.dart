import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/providers/entries_provider.dart';

class TestEntriesProvider implements EntriesProvider {
  @override
  Stream<List<EntryInfo>> getEntries(String deviceId) {
    return Stream.fromFuture(Future.delayed(
      Duration(seconds: 3),
      () {
        return [
          FileInfo(
            id: "1",
            name: "Contract.txt",
            status: EntryStatus.LOADING,
            downloadedBytes: 210763776,
            summaryBytes: 2151677952,
          ),
          FolderInfo(
            id: "2",
            name: "Photos",
            status: EntryStatus.LOADING,
            downloadedBytes: 38797312,
            summaryBytes: 47185920,
            downloadedFiles: 17,
            filesCount: 20,
          )
        ];
      },
    ));
  }

  @override
  Stream<FileInfo> getFile(String id) {
    // TODO: implement getFile
    throw UnimplementedError();
  }

  @override
  Stream<FolderInfo> getFolder(String id) {
    // TODO: implement getFolder
    throw UnimplementedError();
  }
}
