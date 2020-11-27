import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'transition_icon_state.g.dart';

class TransitionIconState = _AnimatedIconState with _$TransitionIconState;

abstract class _AnimatedIconState with Store {
  @observable
  IconData startAnimatedIconData;

  @observable
  IconData endAnimatedIconData;

  @observable
  Color animatedIconColor;

  @action
  void setStartAnimatedIconData(IconData iconData) {
    startAnimatedIconData = iconData;
  }

  @action
  void setEndAnimatedIconData(IconData iconData) {
    endAnimatedIconData = iconData;
  }

  @action
  void setAnimatedIconColor(Color color) {
    animatedIconColor = color;
  }
}
