import 'dart:math';
import 'package:droply/common/aquarium/aquarium_state.dart';
import 'package:droply/common/ui/icon/transition_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../constants.dart';

class Aquarium extends StatefulWidget {
  final AquariumState _state;

  Aquarium(this._state);

  @override
  State<StatefulWidget> createState() => _AquariumState(
        _state,
      );
}

class _AquariumState extends State<Aquarium> with TickerProviderStateMixin {
  AnimationController _wavePositionAnimationController;
  AnimationController _waveScaleAnimationController;
  TransitionIconController _doneIconAnimator;
  Animation<double> _wavePositionAnimation;
  Animation<double> _waveScaleAnimation;
  final AquariumState _state;

  _AquariumState(
    this._state,
  );

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

    _doneIconAnimator = TransitionIconController();

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

    reaction((_) => _state.showLiquidAnimation, (enabled) {
      if (enabled) {
        _waveScaleAnimationController.forward();
        _wavePositionAnimationController.forward();
        _state.setBackgroundColor(AppColors.lightenProcessColor);
        _doneIconAnimator.animateProcess();
      } else {
        _waveScaleAnimationController.stop();
        _wavePositionAnimationController.stop();

        //TODO: Добавить интерполяцию на анимации кривых линий
        _doneIconAnimator.animateDone();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = TransitionIcon(
        doneIcon: Icons.done_rounded,
        loadingIcon: _state.loadingIcon,
        deviceIcon: _state.deviceIcon,
        doneIconColor: AppColors.processColor,
        loadingIconColor: AppColors.processColor,
        deviceIconColor: AppColors.accentColor,
        onDone: () {
          _state.setBackgroundColor(AppColors.lightenAccentColor);
        },
        onFinished: () {},
        size: 24,
        controller: _doneIconAnimator,
        animationDuration: 200,
        doneDuration: 200,
        clockwise: true);

    var content = <Widget>[
      icon,
    ];

    if (_state.iconTitle != null) {
      content.add(Text(
        _state.iconTitle.toUpperCase(),
        style: TextStyle(
          color: AppColors.accentColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.bold,
          fontSize: 12,
        ),
      ));
    }

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
                        AppColors.lightProcessColor,
                        _state.backgroundColor,
                        _waveScaleAnimation.value,
                        _wavePositionAnimation.value,
                        _state.progress,
                      ),
                    ));
          },
        ),
        Column(children: content)
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

  _Aquarium(
    Color color,
    this._backgroundColor,
    this._scale,
    this._position,
    this._progress,
  ) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    bool isProcess = _progress > 0 && _progress < 1.0;
    Path path;

    if (isProcess) {
      var points = List<Offset>();

      for (double x = 0; x <= size.width; x++) {
        points.add(Offset(
          x,
          1.5 * sin((x) / (8 + _scale) + _position) +
              size.height * (1 - _progress),
        ));
      }

      points.add(Offset(size.width, size.height));
      points.add(Offset(0, size.height));

      path = Path();
      path.addPolygon(points, true);
    }

    var rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    var clipRect = RRect.fromRectAndCorners(
      rect,
      topRight: _borderRadius,
      topLeft: _borderRadius,
      bottomLeft: _borderRadius,
      bottomRight: _borderRadius,
    );

    canvas.clipRRect(clipRect);
    canvas.drawColor(_backgroundColor, BlendMode.src);

    if (isProcess) {
      canvas.drawPath(path, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _Aquarium old = oldDelegate;

    return old._progress != _progress ||
        old._position != _position ||
        old._scale != _scale;
  }
}
