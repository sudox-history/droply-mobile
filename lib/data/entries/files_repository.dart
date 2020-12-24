import 'package:droply/data/entries/models/entry_info.dart';
import 'package:droply/data/entries/providers/files_provider.dart';
import 'package:flutter/foundation.dart';

import 'models/file_info.dart';
import 'models/folder_info.dart';

class EntriesRepository {
  EntriesProvider provider;

  EntriesRepository({
    @required this.provider,
  });

  Stream<FileInfo> getFile(String id) {
    return provider.getFile(id);
  }

  Stream<FolderInfo> getFolder(String id) {
    return provider.getFolder(id);
  }

  Stream<List<EntryInfo>> getEntries(String deviceId) {
    return provider.getEntries(deviceId);
  }
}
