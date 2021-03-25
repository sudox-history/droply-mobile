import 'package:droply/constants.dart';
import 'package:droply/data/entries/entries_repository.dart';
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

  const FileWidget({
    this.initialState,
  });

  @override
  State<StatefulWidget> createState() => FileWidgetState();
}

class FileWidgetState extends State<FileWidget> {
  final GlobalKey<AquariumState> _aquariumKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final EntriesRepository repository = RepositoryProvider.of<EntriesRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 7.5, bottom: 7.5, left: 16),
      child: BlocProvider(
        create: (context) => FileBloc(initialState: widget.initialState, repository: repository),
        child: Row(
          children: [
            BlocConsumer<FileBloc, FileState>(
              buildWhen: (state, context) => false,
              builder: (context, state) {
                return Aquarium(
                  key: _aquariumKey,
                  doneIcon: Icons.done_rounded,
                  idleIcon: Icons.insert_drive_file,
                  iconTitle: state.extension,
                );
              },
              listener: (context, state) {
                if (state is LoadingFileState) {
                  _aquariumKey.currentState.progressIcon = Icons.insert_drive_file_rounded;
                  _aquariumKey.currentState.setProgress(state.progress);
                } else if (state is CompletedFileState) {
                  _aquariumKey.currentState.setIdle();
                }
              },
            ),
            const SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<FileBloc, FileState>(
                builder: (context, state) {
                  Widget widget;
                  const TextStyle bytesStyle = TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 15,
                    color: AppColors.secondaryTextColor,
                  );

                  if (state is LoadingFileState) {
                    widget = Row(
                      children: [
                        Text(
                          "${shortenBytes(state.downloadedBytes)} / ${shortenBytes(state.summaryBytes)}",
                          style: bytesStyle,
                        ),
                      ],
                    );
                  } else if (state is CompletedFileState) {
                    widget = Row(
                      children: [
                        Text(
                          shortenBytes(state.summaryBytes),
                          style: bytesStyle,
                        ),
                        // TODO: Time formatting
                        const Text(
                          " - 3:30 PM, 31 December",
                          style: TextStyle(
                            fontFamily: AppFonts.openSans,
                            fontWeight: AppFonts.regular,
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
                        style: const TextStyle(
                          color: AppColors.onSurfaceColor,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.semibold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      widget,
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
