import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarTitleBloc extends Bloc<dynamic, ToolbarTitleState> {
  ToolbarTitleBloc() : super(ToolbarTitleState(true));

  @override
  Stream<ToolbarTitleState> mapEventToState(event) => Stream.value(ToolbarTitleState(true));
}

class ToolbarTitleState {
  final bool isConnected;

  ToolbarTitleState(
    this.isConnected,
  );
}
