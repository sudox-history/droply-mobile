import 'dart:math';
import 'package:async/async.dart';
import 'package:droply/constants.dart';
import 'package:droply/presentation/common/icon/transition_icon.dart';
import 'package:flutter/material.dart';

class Aquarium extends StatefulWidget {
  final IconData idleIcon;
  final IconData doneIcon;

  Aquarium({
    Key key,
    @required this.idleIcon,
    @required this.doneIcon,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AquariumState();
}

class AquariumState extends State<Aquarium> with TickerProviderStateMixin {
  AnimationController _wavePositionAnimationController;
  CancelableOperation _idleIconSettingOperation;
  AnimationController _waveScaleAnimationController;
  Animation<double> _wavePositionAnimation;
  Animation<double> _waveScaleAnimation;

  GlobalKey<TransitionIconState> _iconKey = GlobalKey();
  Color _backgroundColor = AppColors.lightenAccentColor;
  Color _iconColor = AppColors.accentColor;
  bool _isWaveEnabled = false;
  IconData _progressIcon;
  double _progress = 0;
  String _iconTitle;

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
  }

  @override
  Widget build(BuildContext context) {
    var content = <Widget>[
      TransitionIcon(
        key: _iconKey,
        animationDuration: 250,
        size: 24,
      )
    ];

    if (_iconTitle != null) {
      content.add(Text(
        _iconTitle.toUpperCase(),
        style: TextStyle(
          color: _iconColor,
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
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(60),
            painter: _Aquarium(
              AppColors.lightProcessColor,
              _backgroundColor,
              _waveScaleAnimation.value,
              _wavePositionAnimation.value,
              _progress,
            ),
          ),
        ),
        Column(children: content)
      ],
    );
  }

  set progress(double progress) {
    if (_progress == progress) {
      return;
    }

    _progress = progress;

    if (progress > 0 && progress < 1) {
      if (!_isWaveEnabled) {
        _isWaveEnabled = true;
        _iconColor = AppColors.processColor;
        _backgroundColor = AppColors.lightenProcessColor;
        _waveScaleAnimationController.forward();
        _wavePositionAnimationController.forward();
        _cancelIdleIconSettingOperation();
        _iconKey.currentState.changeIcon(_progressIcon, AppColors.processColor);
      }
    } else {
      _isWaveEnabled = false;
      _waveScaleAnimationController.stop();
      _waveScaleAnimationController.reset();
      _wavePositionAnimationController.stop();
      _wavePositionAnimationController.reset();
      setState(() {});
    }
  }

  void setIdle() {
    progress = 1.0;

    if (_iconKey.currentState.icon != null &&
        _iconKey.currentState.icon == _progressIcon) {
      _cancelIdleIconSettingOperation();
      _setIdleBackground();

      _iconKey.currentState.onAnimationDone = () {
        _idleIconSettingOperation = CancelableOperation.fromFuture(
          Future.delayed(Duration(seconds: 2), () {
            _iconKey.currentState.onAnimationDone = () {
              _idleIconSettingOperation = null;
              _iconKey.currentState.onAnimationDone = null;
            };

            _iconKey.currentState.changeIcon(
              widget.idleIcon,
              AppColors.accentColor,
            );
          }),
        );
      };

      _iconKey.currentState.changeIcon(widget.doneIcon, AppColors.accentColor);
    } else {
      _setIdleBackground();

      if (_iconKey.currentState.onAnimationDone == null) {
        _iconKey.currentState
            .changeIcon(widget.idleIcon, AppColors.accentColor);
      }
    }
  }

  void _setIdleBackground() {
    Color color = AppColors.lightenAccentColor;

    if (_backgroundColor != color) {
      setState(() {
        _backgroundColor = color;
      });
    }
  }

  void _cancelIdleIconSettingOperation() {
    _idleIconSettingOperation?.cancel();
    _idleIconSettingOperation = null;
  }

  set progressIcon(IconData data) {
    _progressIcon = data;
  }

  @override
  void dispose() {
    _waveScaleAnimationController.dispose();
    _wavePositionAnimationController.dispose();
    _cancelIdleIconSettingOperation();
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
