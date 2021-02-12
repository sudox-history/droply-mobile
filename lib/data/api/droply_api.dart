import 'dart:async';

import 'package:cobra_flutter/socket/socket.dart';
import 'package:cobra_flutter/socket/socket_events.dart';
import 'package:droply/data/api/droply_api_event.dart';

const String _API_HOST = "droply.ru";
const String _API_PORT = "5555";

class DroplyApi {
  CobraSocket _socket;
  StreamController<DroplyApiEvent> _streamController =
      StreamController<DroplyApiEvent>();

  Stream<DroplyApiEvent> get stream => _streamController.stream;

  void connect() async {
    try {
      _socket = await CobraSocket.connect(_API_HOST, _API_PORT, 32);
      _socket.stream.listen((data) {
        if (data is CobraSocketDataEvent) {
          // TODO: Deserialize
        } else if (data is CobraSocketDrainEvent) {
          // TODO: Sends requests from queue & resume uploading
        }
      }, onDone: () {
        _streamController.sink.add(DroplyApiNetworkErrorEvent());
      });

      _streamController.sink.add(DroplyApiConnectedEvent());
    } catch (ex) {
      _streamController.sink.add(DroplyApiNetworkErrorEvent());
    }
  }
}
