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
  Color _oldColor;
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
          onAnimationDone?.call();

          setState(() {
            _oldIcon = null;
            _oldColor = null;
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.isAnimating || _oldColor == null) {
      return Icon(
        _icon,
        size: widget.size,
        color: _color,
      );
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
            color: _oldColor.withOpacity(1 - progress),
          ),
        ),
        Transform.rotate(
          angle: math.pi - math.pi * progress,
          child: Icon(
            _icon,
            size: widget.size,
            color: _color.withOpacity(progress),
          ),
        )
      ],
    );
  }

  void changeIcon(IconData icon, Color color) {
    _oldIcon = _icon;
    _oldColor = _color;

    if (_icon != null && _icon != icon) {
      _icon = icon;
      _color = color;

      _controller.reset();
      _controller.forward();
    } else if (_icon == null) {
      setState(() {
        _icon = icon;
        _color = color;
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
