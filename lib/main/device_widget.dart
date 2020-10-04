import 'dart:ui';

import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DeviceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DeviceAquarium(),
      ],
    );
  }
}

class _DeviceAquarium extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeviceAquariumState();
}

class _DeviceAquariumState extends State<_DeviceAquarium> with TickerProviderStateMixin {
  AnimationController _waveScaleAnimationController;
  Animation<double> _waveScaleAnimation;

  AnimationController _wavePositionAnimationController;
  Animation<double> _wavePositionAnimation;

  @override
  void initState() {
    super.initState();

    _waveScaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _wavePositionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _wavePositionAnimation = Tween(
      begin: 4 * pi,
      end: 0.0,
    ).animate(_wavePositionAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _wavePositionAnimationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _wavePositionAnimationController.forward();
        }
      });

    _waveScaleAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(_waveScaleAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _waveScaleAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _waveScaleAnimationController.forward();
        }
      });

    _waveScaleAnimationController.forward();
    _wavePositionAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wavePositionAnimation,
      builder: (context, snapshot) {
        return CustomPaint(
          size: Size.square(60),
          painter: _DeviceAquariumPainter(
            AppColors.blue,
            0.5,
            _waveScaleAnimation.value,
            _wavePositionAnimation.value,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _waveScaleAnimationController.dispose();
    _wavePositionAnimationController.dispose();
    super.dispose();
  }
}

class _DeviceAquariumPainter extends CustomPainter {
  Paint _paint = Paint();
  double _progress;
  double _scale;
  double _position;

  _DeviceAquariumPainter(Color color, this._progress, this._scale, this._position) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var points = List<Offset>();
    var path = Path(); // [2;7]
    var a = -0.4; // [0; 4Pi]

    for (double x = 0; x <= size.width; x++) {
      points.add(Offset(
        x,
        sin((x) / (8 + _scale) + _position) + size.height * (1 - _progress),
      ));
    }

    points.add(Offset(size.width, size.height));
    points.add(Offset(0, size.height));
    path.addPolygon(points, true);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _DeviceAquariumPainter old = oldDelegate;

    return old._progress != _progress || old._position != _position || old._scale != _scale;
  }
}
