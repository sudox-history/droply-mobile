import 'dart:async';

import 'package:droply/data/managers/connection_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarBloc extends Bloc<ConnectionStatus, ToolbarState> {
  StreamSubscription<ConnectionStatus> _subscription;

  ToolbarBloc(
    ConnectionManager manager,
  ) : super(ToolbarState(manager.isConnected)) {
    _subscription = manager.statusStream.listen(add);
  }

  @override
  Stream<ToolbarState> mapEventToState(event) =>
      Stream.value(ToolbarState(event == ConnectionStatus.CONNECTED));

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}

class ToolbarState {
  final bool isConnected;

  ToolbarState(
    this.isConnected,
  );
}
