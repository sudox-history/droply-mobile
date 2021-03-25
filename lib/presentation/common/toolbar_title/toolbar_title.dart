import 'package:droply/presentation/common/toolbar_title/toolbar_title_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarTitle extends StatefulWidget {
  final String title;

  const ToolbarTitle(
    this.title,
  );

  @override
  State<StatefulWidget> createState() => _ToolbarTitleState();
}

class _ToolbarTitleState extends State<ToolbarTitle> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToolbarTitleBloc(),
      child: BlocBuilder<ToolbarTitleBloc, ToolbarTitleState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            state.isConnected ? widget.title : "Connecting ...",
            key: ValueKey(state.isConnected),
          ),
        ),
      ),
    );
  }
}
