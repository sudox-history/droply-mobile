import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransitionIcon extends StatefulWidget {
  final int animationDuration;
  final double size;

  TransitionIcon({
    Key key,
    @required this.animationDuration,
    @required this.size,
  }) : super(key: key);

  @override
  TransitionIconState createState() => TransitionIconState();
}

class TransitionIconState extends State<TransitionIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Function onAnimationDone;
  IconData _oldIcon;
  IconData _icon;
  Color _color;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onAnimationDone();

          setState(() {
            _oldIcon = null;
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Icon icon = Icon(
      _icon,
      size: widget.size,
      color: _color,
    );

    if (!_controller.isAnimating) {
      return icon;
    }

    double progress = _controller.value;

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: -progress * math.pi,
          child: Icon(
            _oldIcon,
            size: widget.size,
            color: _color,
          ),
        ),
        Transform.rotate(
          angle: math.pi - math.pi * progress,
          child: icon,
        )
      ],
    );
  }

  set icon(IconData icon) {
    _oldIcon = _icon;

    if (_icon != null && _icon != icon) {
      _icon = icon;

      _controller.reset();
      _controller.forward();
    } else if (_icon == null) {
      setState(() {
        _icon = icon;
      });
    }
  }

  get icon => _icon;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
