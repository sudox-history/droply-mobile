import 'dart:async';
import 'dart:collection';

import 'package:droply/data/api/droply_api.dart';
import 'package:droply/data/api/droply_api_status_event.dart';

class ConnectionManager {
  final DroplyApi _api;
  final StreamController<ConnectionStatus> _statusStreamController =
      StreamController<ConnectionStatus>();

  bool get isConnected => _api.isConnected;
  Stream<ConnectionStatus> get statusStream => _statusStreamController.stream;

  ConnectionManager(this._api);

  void start() async {
    _api.statusStream.listen((data) {
      if (data is DroplyApiConnectedEvent) {
        _statusStreamController.add(ConnectionStatus.CONNECTED);
      } else if (data is DroplyApiNetworkErrorEvent) {
        _statusStreamController.add(ConnectionStatus.CONNECTING);
        _api.connect();
      }
    });

    _api.connect();
  }

  void stop() async {
    // TODO: Close
  }
}

enum ConnectionStatus {
  CONNECTED,
  CONNECTING,
}
