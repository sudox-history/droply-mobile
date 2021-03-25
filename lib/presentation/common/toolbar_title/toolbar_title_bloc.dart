import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarTitleBloc extends Bloc<dynamic, ToolbarTitleState> {
  ToolbarTitleBloc() : super(ToolbarTitleState(isConnected: true));

  @override
  Stream<ToolbarTitleState> mapEventToState(dynamic event) => Stream.value(ToolbarTitleState(isConnected: true));
}

class ToolbarTitleState {
  final bool isConnected;

  ToolbarTitleState({
    this.isConnected,
  });
}
