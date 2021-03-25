import 'package:droply/constants.dart';
import 'package:droply/presentation/common/device/my_device/my_device_bloc.dart';
import 'package:droply/presentation/common/device/my_device/my_device_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDevice extends StatefulWidget {
  const MyDevice();

  @override
  State<StatefulWidget> createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyDeviceBloc>(
      create: (context) => MyDeviceBloc(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightAccentColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: BlocBuilder<MyDeviceBloc, MyDeviceState>(
          builder: (context, state) {
            if (state is MyDeviceLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(state.icon, color: AppColors.accentColor),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Text(
                      state.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.accentColor,
                        fontFamily: AppFonts.openSans,
                        fontWeight: AppFonts.semibold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              );
            }

            return const FractionallySizedBox(
              heightFactor: 0.25,
              widthFactor: 0.25,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
        ),
      ),
    );
  }
}
