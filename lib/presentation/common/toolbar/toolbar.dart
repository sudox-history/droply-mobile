import 'package:droply/data/managers/connection_manager.dart';
import 'package:droply/presentation/common/toolbar/toolbar_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Toolbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;

  @override
  final Size preferredSize;

  Toolbar({
    @required this.title,
    this.actions,
    this.bottom,
  }) : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
    var manager = RepositoryProvider.of<ConnectionManager>(context);

    return BlocProvider(
      create: (context) => ToolbarBloc(manager),
      child: BlocBuilder<ToolbarBloc, ToolbarState>(
        builder: (context, state) => AppBar(
          title: Text(state.isConnected ? widget.title : "Connecting"),
          actions: widget.actions,
          bottom: widget.bottom,
        ),
      ),
    );
  }
}
