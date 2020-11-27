import 'package:droply/common/ui/icon/transition_icon_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_mobx/flutter_mobx.dart';

class TransitionIcon extends StatefulWidget {
  final IconData doneIcon, loadingIcon, deviceIcon;
  final Color doneIconColor, loadingIconColor, deviceIconColor;
  final void Function() onDone, onFinished;
  final int animationDuration, doneDuration;
  final bool clockwise;
  final double size;
  final TransitionIconController controller;

  const TransitionIcon({
    @required this.doneIcon,
    @required this.loadingIcon,
    @required this.deviceIcon,
    @required this.doneIconColor,
    @required this.loadingIconColor,
    @required this.deviceIconColor,
    @required this.onDone,
    @required this.onFinished,
    @required this.size,
    @required this.controller,
    @required this.animationDuration,
    @required this.doneDuration,
    @required this.clockwise,
  });

  @override
  _TransitionIconState createState() => _TransitionIconState();
}

class _TransitionIconState extends State<TransitionIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  TransitionIconState state = TransitionIconState();

  @override
  void initState() {
    this._controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration ?? 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    this._controller.addListener(() {
      setState(() {});
    });

    initControllerFunctions();
    super.initState();
  }

  var isProcess = true;
  var isDone = true;

  initControllerFunctions() {
    if (widget.controller != null) {
      state.setAnimatedIconColor(widget.deviceIconColor);
      state.setStartAnimatedIconData(widget.deviceIcon);
      state.setEndAnimatedIconData(widget.deviceIcon);

      widget.controller.animateDone = () {
        _controller.reset();
        state.setStartAnimatedIconData(widget.loadingIcon);
        state.setEndAnimatedIconData(widget.doneIcon);
        _controller.forward();
      };

      widget.controller.animateProcess = () {
        isProcess = true;
        _controller.reset();
        state.setAnimatedIconColor(widget.loadingIconColor);
        state.setStartAnimatedIconData(widget.deviceIcon);
        state.setEndAnimatedIconData(widget.loadingIcon);
        _controller.forward();
      };

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (isProcess) {
            isProcess = false;

          } else {
            if (isDone) {
              state.setAnimatedIconColor(widget.doneIconColor);
              Future.delayed(Duration(milliseconds: 2000)).then((value) => {
                    state.setAnimatedIconColor(widget.deviceIconColor),
                    widget.onDone(),
                    _controller.reset(),
                    state.setStartAnimatedIconData(widget.doneIcon),
                    state.setEndAnimatedIconData(widget.deviceIcon),
                    _controller.forward()
                  });
            } else {
              widget.onFinished();
            }
            isDone = !isDone;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double x = _controller.value ?? 0.0;
    double y = 1.0 - _controller.value ?? 0.0;
    double angleX = math.pi / 180 * (180 * x);
    double angleY = math.pi / 180 * (180 * y);

    Widget first() {
      return Transform.rotate(
        angle: widget.clockwise ?? false ? angleX : -angleX,
        child: Opacity(
            opacity: y,
            child: Observer(
              builder: (_) => Icon(
                state.startAnimatedIconData,
                size: widget.size,
                color: state.animatedIconColor,
              ),
            )),
      );
    }

    Widget second() {
      return Transform.rotate(
          angle: widget.clockwise ?? false ? -angleY : angleY,
          child: Opacity(
            opacity: x ?? 0.0,
            child: Observer(
                builder: (_) => Icon(
                      state.endAnimatedIconData,
                      size: widget.size,
                      color: state.animatedIconColor,
                    )),
          ));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        x == 1 && y == 0 ? second() : first(),
        x == 0 && y == 1 ? first() : second(),
      ],
    );
  }
}

class TransitionIconController {
  void Function() animateDone, animateProcess;
}
