import 'dart:async';

import 'package:droply/data/managers/connection_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarTitleBloc extends Bloc<ConnectionStatus, ToolbarTitleState> {
  StreamSubscription<ConnectionStatus> _subscription;

  ToolbarTitleBloc(
    ConnectionManager manager,
  ) : super(ToolbarTitleState(manager.isConnected)) {
    _subscription = manager.statusStream.listen(add);
  }

  @override
  Stream<ToolbarTitleState> mapEventToState(event) =>
      Stream.value(ToolbarTitleState(event == ConnectionStatus.CONNECTED));

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}

class ToolbarTitleState {
  final bool isConnected;

  ToolbarTitleState(
    this.isConnected,
  );
}
