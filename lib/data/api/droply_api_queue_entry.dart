import 'dart:async';

class DroplyApiRequestEntry {
  final Completer<Map<String, dynamic>> completer;
  final Map<String, dynamic> data;

  DroplyApiRequestEntry(this.completer, this.data);
}
