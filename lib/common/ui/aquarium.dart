import 'dart:math';
import 'package:droply/main/nearby_screen.dart';
import 'package:droply/state/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Aquarium extends StatefulWidget {
  final Color _backgroundColor;
  final Color _liquidColor;
  final Color _iconColor;
  final IconData _icon;
  final Progress _progress;

  Aquarium(this._backgroundColor, this._liquidColor, this._iconColor, this._icon, this._progress);

  @override
  State<StatefulWidget> createState() =>
      _AquariumState(_backgroundColor, _liquidColor, _iconColor, _icon, _progress);
}

class _AquariumState extends State<Aquarium> with TickerProviderStateMixin {
  AnimationController _wavePositionAnimationController;
  AnimationController _waveScaleAnimationController;
  Animation<double> _wavePositionAnimation;
  Animation<double> _waveScaleAnimation;
  final Color _backgroundColor;
  final Color _liquidColor;
  final Color _iconColor;
  final IconData _icon;
  final Progress _progress;

  _AquariumState(
      this._backgroundColor, this._liquidColor, this._iconColor, this._icon, this._progress);

  @override
  void initState() {
    super.initState();

    _waveScaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _wavePositionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedBuilder(
          animation: _wavePositionAnimation,
          builder: (context, snapshot) {
            return Observer(
              builder: (_) => CustomPaint(
                size: Size.square(60),
                painter: _Aquarium(
                  _liquidColor,
                  _backgroundColor,
                  _waveScaleAnimation.value,
                  _wavePositionAnimation.value,
                  _progress.progress,
                ),
              ),
            );
          },
        ),
        Icon(
          _icon,
          color: _iconColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _waveScaleAnimationController.dispose();
    _wavePositionAnimationController.dispose();
    super.dispose();
  }
}

class _Aquarium extends CustomPainter {
  static const _borderRadius = Radius.circular(15);

  final Paint _paint = Paint();
  final Color _backgroundColor;
  final double _progress;
  final double _scale;
  final double _position;

  _Aquarium(Color color, this._backgroundColor, this._scale, this._position, this._progress) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var points = List<Offset>();

    for (double x = 0; x <= size.width; x++) {
      points.add(Offset(
        x,
        1.5 * sin((x) / (8 + _scale) + _position) + size.height * (1 - _progress),
      ));
    }

    points.add(Offset(size.width, size.height));
    points.add(Offset(0, size.height));

    var path = Path();
    var rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    var clipRect = RRect.fromRectAndCorners(
      rect,
      topRight: _borderRadius,
      topLeft: _borderRadius,
      bottomLeft: _borderRadius,
      bottomRight: _borderRadius,
    );

    path.addPolygon(points, true);
    canvas.clipRRect(clipRect);
    canvas.drawColor(_backgroundColor, BlendMode.src);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _Aquarium old = oldDelegate;
    return old._progress != _progress || old._position != _position || old._scale != _scale;
  }
}
