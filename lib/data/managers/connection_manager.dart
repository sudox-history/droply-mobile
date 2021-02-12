import 'dart:async';

import 'package:droply/data/api/droply_api.dart';
import 'package:droply/data/api/droply_api_event.dart';

class ConnectionManager {
  final DroplyApi _api;
  final StreamController<ConnectionStatus> _statusStreamController =
      StreamController<ConnectionStatus>();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Stream<ConnectionStatus> get statusStream => _statusStreamController.stream;

  ConnectionManager(this._api);

  void start() {
    _api.stream.listen((data) {
      if (data is DroplyApiConnectedEvent) {
        _isConnected = true;
        _statusStreamController.add(ConnectionStatus.CONNECTED);
      } else if (data is DroplyApiNetworkErrorEvent) {
        _isConnected = false;
        _statusStreamController.add(ConnectionStatus.CONNECTING);
        _api.connect();
      }
    });

    _api.connect();
  }
}

enum ConnectionStatus {
  CONNECTED,
  CONNECTING,
}
