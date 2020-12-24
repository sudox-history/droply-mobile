import 'package:droply/constants.dart';
import 'package:droply/data/entries/files_repository.dart';
import 'package:droply/data/entries/models/file_info.dart';
import 'package:droply/helpers/unit_helper.dart';
import 'package:droply/presentation/common/aquarium/aquarium.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file_bloc.dart';
import 'file_state.dart';

class FileWidget extends StatefulWidget {
  final FileInfo initialState;

  FileWidget({
    this.initialState,
  });

  @override
  State<StatefulWidget> createState() => FileWidgetState();
}

class FileWidgetState extends State<FileWidget> {
  final GlobalKey<AquariumState> _aquariumKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    EntriesRepository repository =
        RepositoryProvider.of<EntriesRepository>(context);

    return Padding(
      child: BlocProvider(
        create: (context) =>
            FileBloc(initialState: widget.initialState, repository: repository),
        child: Row(
          children: [
            Container(
              child: BlocConsumer<FileBloc, FileState>(
                buildWhen: (state, context) => false,
                builder: (context, state) {
                  return Aquarium(
                    key: _aquariumKey,
                    doneIcon: Icons.done_rounded,
                    idleIcon: Icons.folder_rounded,
                    iconTitle: state.extension,
                  );
                },
                listener: (context, state) {
                  if (state is LoadingFileState) {
                    _aquariumKey.currentState.progress = state.progress;
                  } else if (state is CompletedFileState) {
                    _aquariumKey.currentState.setIdle();
                  }
                },
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<FileBloc, FileState>(
                builder: (context, state) {
                  Widget widget;
                  TextStyle bytesStyle = TextStyle(
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.semibold,
                      fontSize: 15,
                      color: AppColors.secondaryTextColor);

                  if (state is LoadingFileState) {
                    widget = Row(
                      children: [
                        Text(
                          "${shortenBytes(state.downloadedBytes)}/${shortenBytes(state.summaryBytes)}",
                          style: bytesStyle,
                        ),
                      ],
                    );
                  } else if (state is CompletedFileState) {
                    widget = Row(
                      children: [
                        Text(
                          "${shortenBytes(state.summaryBytes)}",
                          style: bytesStyle,
                        ),
                        // TODO: Time formatting
                        Text(
                          " - 3:30 PM, 31 December",
                          style: TextStyle(
                            fontFamily: AppFonts.openSans,
                            fontWeight: AppFonts.semibold,
                            fontSize: 15,
                            color: AppColors.hintTextColor,
                          ),
                        )
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.name,
                        style: TextStyle(
                          color: AppColors.onSurfaceColor,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.semibold,
                          fontSize: 17,
                        ),
                      ),
                      widget,
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.only(top: 7.5, bottom: 7.5, left: 16),
    );
  }
}
