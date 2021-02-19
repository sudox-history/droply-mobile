import 'package:droply/data/managers/connection_manager.dart';
import 'package:droply/presentation/common/toolbar_title/toolbar_title_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarTitle extends StatefulWidget {
  final String title;

  ToolbarTitle(
    this.title,
  );

  @override
  State<StatefulWidget> createState() => _ToolbarTitleState();
}

class _ToolbarTitleState extends State<ToolbarTitle> {
  @override
  Widget build(BuildContext context) {
    var manager = RepositoryProvider.of<ConnectionManager>(context);

    return BlocProvider(
      create: (context) => ToolbarTitleBloc(manager),
      child: BlocBuilder<ToolbarTitleBloc, ToolbarTitleState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Text(
            state.isConnected ? widget.title : "Connecting ...",
            key: ValueKey(state.isConnected),
          ),
        ),
      ),
    );
  }
}
