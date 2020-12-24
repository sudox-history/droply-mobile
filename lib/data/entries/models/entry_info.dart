import 'package:flutter/foundation.dart';

abstract class EntryInfo {
  final String id;
  final String name;
  final EntryStatus status;
  final int downloadedBytes;
  final int summaryBytes;
  final int completedTime;

  EntryInfo({
    @required this.id,
    @required this.name,
    this.status,
    this.downloadedBytes,
    this.summaryBytes,
    this.completedTime,
  });

  double get progress => downloadedBytes / summaryBytes;
}

enum EntryStatus { COMPLETED, LOADING }
