import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/presentation/common/other_widgets.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_bloc.dart';
import 'package:droply/presentation/main/nearby/nearby_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NearbyScreenState();
}

class NearbyScreenState extends State<NearbyScreen> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    DevicesRepository repository =
        RepositoryProvider.of<DevicesRepository>(context);

    return BlocProvider(
      create: (context) => NearbyScreenBloc(devicesRepository: repository),
      child: BlocConsumer<NearbyScreenBloc, NearbyScreenBlocState>(
        buildWhen: (previous, current) =>
            (previous is NearbyScreenLoadingState &&
                !(current is NearbyScreenScanningState)) ||
            !(previous is NearbyScreenLoadingState) &&
                current is NearbyScreenScanningState,
        listenWhen: (previous, current) {
          if (!(previous is NearbyScreenScanningState) &&
              current is NearbyScreenScanningState) {
            _listKey.currentState.insertItem(1);
          } else if (previous is NearbyScreenScanningState &&
              !(current is NearbyScreenScanningState)) {
            _listKey.currentState
                .removeItem(1, (_, animation) => _buildItem(1, animation));
          }

          return false;
        },
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NearbyScreenLoadingState) {
            return buildScreenLoader();
          } else {
            return AnimatedList(
              key: _listKey,
              padding: EdgeInsets.only(top: 20),
              initialItemCount: 1,
              itemBuilder: (context, position, animation) {
                return _buildItem(position, animation);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(position, animation) {
    Widget widget;

    if (position == 0) {
      widget = _buildScanNearbyOption(context);
    } else if (position == 1) {
      widget = _buildScanningHint();
    }

    return ScaleTransition(
      scale: animation,
      child: widget,
    );
  }

  Widget _buildScanNearbyOption(BuildContext context) {
    return BlocBuilder<NearbyScreenBloc, NearbyScreenBlocState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: buildSwitchSetting(
            "Scan devices nearby",
            "We'll show you devices that also use EasyShare",
            state is NearbyScreenScanningState,
            (checked) {
              BlocProvider.of<NearbyScreenBloc>(context).add(checked);
            },
          ),
        );
      },
    );
  }

  Widget _buildScanningHint() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 12.5, left: 16, right: 16),
      child: Text(
        "Scanning for more devices ...",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.hintTextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 17,
        ),
      ),
    );
  }
}
