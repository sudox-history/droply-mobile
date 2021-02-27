import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:cobra_flutter/socket/socket.dart';
import 'package:cobra_flutter/socket/socket_events.dart';
import 'package:droply/data/api/droply_api_io_exception.dart';
import 'package:droply/data/api/droply_api_queue_entry.dart';
import 'package:droply/data/api/droply_api_status_event.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

class DroplyApi {
  CobraSocket _socket;
  StreamSubscription _subscription;

  final Queue<Uint8List> _writeQueue = Queue<Uint8List>();
  final Map<String, StreamController<Map<String, dynamic>>> _controllers =
      Map<String, StreamController<Map<String, dynamic>>>();
  final Map<String, Queue<DroplyApiRequestEntry>> _requestsMap =
      Map<String, Queue<DroplyApiRequestEntry>>();
  final StreamController<DroplyApiStatusEvent> _statusStreamController =
      StreamController<DroplyApiStatusEvent>();

  bool get isConnected => _socket != null;
  Stream<DroplyApiStatusEvent> get statusStream =>
      _statusStreamController.stream;

  void connect() async {
    try {
      _socket = await CobraSocket.connect("droply.ru", "5555",
          writeQueueLength: 32, connectTimeout: const Duration(seconds: 5));

      _subscription = _socket.stream.listen((event) {
        if (event is CobraSocketDataEvent) {
          var map = deserialize(event.data);
          var name = map["name"];
          var data = map["data"];

          if (_requestsMap.containsKey(name)) {
            _requestsMap[name].removeFirst().completer.complete(data);

            if (_requestsMap[name].isNotEmpty) {
              emit(name, _requestsMap[name].first.data);
            } else {
              _requestsMap.remove(name);
            }
          } else {}
        } else if (event is CobraSocketDrainEvent) {
          _writeQueue.forEach(_socket.sink.add);
        } else if (event is CobraSocketSentEvent) {
          _writeQueue.removeFirst();
        }
      }, onDone: () {
        _socket = null;
        _subscription.cancel();
        _writeQueue.clear();
        _requestsMap.entries.forEach((mapEntry) {
          mapEntry.value.forEach((entry) {
            entry.completer.completeError(DroplyApiIOException());
          });
        });

        _requestsMap.clear();
        _statusStreamController.sink.add(const DroplyApiNetworkErrorEvent());
      }, onError: (error) {});

      _statusStreamController.sink.add(const DroplyApiConnectedEvent());
    } catch (ex) {
      _statusStreamController.sink.add(const DroplyApiNetworkErrorEvent());
    }
  }

  Future<Map<String, dynamic>> request(String name, Map<String, dynamic> data) {
    var completer = Completer<Map<String, dynamic>>();

    if (isConnected != null) {
      var entry = DroplyApiRequestEntry(completer, data);

      if (_requestsMap.containsKey(name)) {
        _requestsMap[name].addLast(entry);
      } else {
        _requestsMap[name] = Queue.of([entry]);
        emit(name, data);
      }
    } else {
      completer.completeError(DroplyApiIOException());
    }

    return completer.future;
  }

  Stream<Map<String, dynamic>> listen(String name) {
    if (!_controllers.containsKey(name)) {
      _controllers[name] = StreamController.broadcast(onCancel: () {
        _controllers.remove(name);
      });
    }

    return _controllers[name].stream;
  }

  void emit(String name, Map<String, dynamic> data) {
    if (isConnected) {
      var map = Map<String, dynamic>();
      map["name"] = name;
      map["data"] = data;

      _send(serialize(map));
    }
  }

  void _send(Uint8List bytes) {
    if (isConnected) {
      _writeQueue.addLast(bytes);
      _socket.sink.add(bytes);
    }
  }

  Future disconnect() async {
    await _socket?.sink?.close();
    await _statusStreamController.close();
  }
}
