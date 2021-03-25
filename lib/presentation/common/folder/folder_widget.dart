import 'package:droply/constants.dart';
import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/models/folder_info.dart';
import 'package:droply/helpers/unit_helper.dart';
import 'package:droply/presentation/common/aquarium/aquarium.dart';
import 'package:droply/presentation/common/folder/folder_bloc.dart';
import 'package:droply/presentation/common/folder/folder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FolderWidget extends StatefulWidget {
  final FolderInfo initialState;

  const FolderWidget({
    this.initialState,
  });

  @override
  State<StatefulWidget> createState() => FolderWidgetState();
}

class FolderWidgetState extends State<FolderWidget> {
  final GlobalKey<AquariumState> _aquariumKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final EntriesRepository repository = RepositoryProvider.of<EntriesRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 7.5, bottom: 7.5, left: 16, right: 16),
      child: BlocProvider(
        create: (context) => FolderBloc(
          initialState: widget.initialState,
          repository: repository,
        ),
        child: Row(
          children: [
            Container(
              child: BlocConsumer<FolderBloc, FolderState>(
                buildWhen: (state, context) => false,
                builder: (context, state) {
                  return Aquarium(
                    key: _aquariumKey,
                    doneIcon: Icons.done_rounded,
                    idleIcon: Icons.folder,
                  );
                },
                listener: (context, state) {
                  if (state is LoadingFolderState) {
                    _aquariumKey.currentState.progressIcon = Icons.folder_rounded;
                    _aquariumKey.currentState.progress = state.progress;
                  } else if (state is CompletedFolderState) {
                    _aquariumKey.currentState.setIdle();
                  }
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: BlocBuilder<FolderBloc, FolderState>(
                builder: (context, state) {
                  Widget widget;
                  const TextStyle bytesStyle = TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 15,
                    color: AppColors.secondaryTextColor,
                  );

                  if (state is LoadingFolderState) {
                    widget = Row(
                      children: [
                        Text(
                          "${shortenBytes(state.downloadedBytes)} / ${shortenBytes(state.summaryBytes)}",
                          style: bytesStyle,
                        ),
                      ],
                    );
                  } else if (state is CompletedFolderState) {
                    widget = Row(
                      children: [
                        Text(shortenBytes(state.summaryBytes), style: bytesStyle),
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
            BlocBuilder<FolderBloc, FolderState>(builder: (context, state) {
              return Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "${state.downloadedFiles} / ${state.filesCount}",
                  style: const TextStyle(
                    fontFamily: AppFonts.openSans,
                    fontWeight: AppFonts.regular,
                    fontSize: 15,
                    color: AppColors.hintTextColor,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
