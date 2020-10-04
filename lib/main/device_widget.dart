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

  @override
  void initState() {
    super.initState();

    _waveScaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _waveScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 7.0,
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
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveScaleAnimation,
      builder: (context, snapshot) {
        return CustomPaint(
            size: Size.square(60), painter: _DeviceAquariumPainter(AppColors.blue, 0.5, _waveScaleAnimation.value));
      },
    );
  }

  @override
  void dispose() {
    _waveScaleAnimationController.dispose();
    super.dispose();
  }
}

class _DeviceAquariumPainter extends CustomPainter {
  Paint _paint = Paint();
  double _progress;
  double _scale;

  _DeviceAquariumPainter(Color color, this._progress, this._scale) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var points = List<Offset>();
    var path = Path(); // [2;7]
    var a = -0.4; // [0; 4Pi]

    for (int i = 0; i < size.width; i++) {
      var y = sin((i + a) / (8 + _scale)) + size.height * (1 - _progress);
      var offset = Offset(i.toDouble(), y);

      points.add(offset);
    }

    points.add(Offset(size.width, size.height));
    points.add(Offset(0, size.height));
    path.addPolygon(points, true);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
