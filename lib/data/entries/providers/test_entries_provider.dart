import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/providers/entries_provider.dart';

class TestEntriesProvider implements EntriesProvider {
  @override
  Stream<List<EntryInfo>> getActiveEntries(String deviceId) {
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
          ),
        ];
      },
    ));
  }

  @override
  Stream<List<EntryInfo>> getHistoryEntries(String deviceId) {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 3), () {
      return [
        FileInfo(
          id: "3",
          name: "Contract.txt",
          status: EntryStatus.COMPLETED,
          downloadedBytes: 2151677952,
          summaryBytes: 2151677952,
        ),
        FileInfo(
          id: "4",
          name: "PageComponent.js",
          status: EntryStatus.COMPLETED,
          downloadedBytes: 10700,
          summaryBytes: 10700,
        ),
        FolderInfo(
          id: "5",
          name: "Photos",
          status: EntryStatus.COMPLETED,
          downloadedBytes: 46137344,
          summaryBytes: 46137344,
          downloadedFiles: 20,
          filesCount: 20,
        ),
      ];
    }));
  }

  @override
  Stream<FileInfo> getFile(String id) {
    switch (id) {
      case "1":
        int downloaded = 0;

        return Stream.periodic(Duration(milliseconds: 50), (count) {
          EntryStatus status;
          downloaded += 10000000;
          double progress = downloaded / 2151677952;

          if (progress >= 1.0) {
            status = EntryStatus.COMPLETED;
          } else {
            status = EntryStatus.LOADING;
          }

          return FileInfo(
            id: "1",
            name: "Contract.txt",
            status: status,
            downloadedBytes: downloaded,
            summaryBytes: 2151677952,
          );
        });
      case "3":
        return Stream.value(
          FileInfo(
            id: "3",
            name: "Contract.txt",
            status: EntryStatus.COMPLETED,
            downloadedBytes: 2151677952,
            summaryBytes: 2151677952,
          ),
        );
      case "4":
        return Stream.value(
          FileInfo(
            id: "4",
            name: "PageComponent.js",
            status: EntryStatus.COMPLETED,
            downloadedBytes: 10700,
            summaryBytes: 10700,
          ),
        );
    }
  }

  @override
  Stream<FolderInfo> getFolder(String id) {
    switch (id) {
      case "2":
        int downloaded = 0;

        return Stream.periodic(Duration(milliseconds: 50), (count) {
          EntryStatus status;
          downloaded += 100000;
          double progress = downloaded / 47185920;

          if (progress >= 1.0) {
            status = EntryStatus.COMPLETED;
          } else {
            status = EntryStatus.LOADING;
          }

          return FolderInfo(
            id: "2",
            name: "Photos",
            status: status,
            downloadedBytes: downloaded,
            summaryBytes: 47185920,
            downloadedFiles: 17,
            filesCount: 20,
          );
        });
      case "5":
        return Stream.value(
          FolderInfo(
            id: "5",
            name: "Photos",
            status: EntryStatus.COMPLETED,
            downloadedBytes: 46137344,
            summaryBytes: 46137344,
            downloadedFiles: 20,
            filesCount: 20,
          ),
        );
    }
  }
}
