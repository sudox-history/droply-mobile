import 'dart:ui';

import 'package:droply/common/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'aquarium_state.g.dart';

class AquariumState = _AquariumState with _$AquariumState;

abstract class _AquariumState with Store {
  @observable
  double progress = 0;

  @computed
  bool get showLiquidAnimation => progress > 0 && progress < 1.0;

  IconData loadingIcon;

  IconData deviceIcon;

  @observable
  String iconTitle;

  Color liquidColor = AppColors.lightProcessColor;

  @observable
  Color backgroundColor = AppColors.lightenAccentColor;

  @action
  void setBackgroundColor(Color color) {
    backgroundColor = color;
  }

  @action
  void setProgress(double progress) {
    this.progress = progress;
  }
}
