import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/data/entries/models/folder_info.dart';

abstract class EntriesProvider {
  Stream<FileInfo> getFile(String id);

  Stream<FolderInfo> getFolder(String id);

  Stream<List<EntryInfo>> getEntries(String deviceId);
}
