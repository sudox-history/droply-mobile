import 'dart:math';
import 'package:async/async.dart';
import 'package:droply/constants.dart';
import 'package:droply/presentation/common/transition_icon/transition_icon.dart';
import 'package:flutter/material.dart';

class Aquarium extends StatefulWidget {
  final IconData idleIcon;
  final IconData doneIcon;
  final String iconTitle;

  const Aquarium({
    Key key,
    @required this.idleIcon,
    @required this.doneIcon,
    this.iconTitle,
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

  final GlobalKey<TransitionIconState> _iconKey = GlobalKey();
  Color _backgroundColor = AppColors.lightenAccentColor;
  Color _iconColor = AppColors.accentColor;
  bool _iconTitleVisibility = true;
  bool _isWaveEnabled = false;
  IconData progressIcon;
  double _progress = 0;
  String _iconTitle;

  @override
  void initState() {
    super.initState();

    _iconTitle = widget.iconTitle;
    _waveScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _wavePositionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _wavePositionAnimation = Tween(
      begin: 4 * pi,
      end: 0.0,
    ).animate(_wavePositionAnimationController)
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
    final content = <Widget>[
      TransitionIcon(
        key: _iconKey,
        animationDuration: 250,
        size: 24,
      )
    ];

    if (_iconTitle != null && _iconTitleVisibility) {
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
          animation: Listenable.merge([
            _wavePositionAnimation,
            _waveScaleAnimation,
          ]),
          builder: (context, snapshot) => CustomPaint(
            size: const Size.square(60),
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

  void setProgress(double progress) {
    if (_progress == progress) {
      return;
    }

    _progress = progress;

    if (progress > 0 && progress < 1) {
      if (!_isWaveEnabled) {
        _isWaveEnabled = true;

        setState(() {
          _iconColor = AppColors.processColor;
          _backgroundColor = AppColors.lightenProcessColor;
        });

        _waveScaleAnimationController.forward();
        _wavePositionAnimationController.forward();
        _cancelIdleIconSettingOperation();
        _iconKey.currentState.changeIcon(
          progressIcon,
          AppColors.processColor,
        );
      }
    } else {
      _isWaveEnabled = false;
      _waveScaleAnimationController.stop();
      _waveScaleAnimationController.reset();
      _wavePositionAnimationController.stop();
      _wavePositionAnimationController.reset();
    }
  }

  void setIdle() {
    setProgress(1.0);

    // TODO: Fix the bug with icons comparing

    if (_iconKey.currentState.icon != null && _iconKey.currentState.icon == progressIcon) {
      _cancelIdleIconSettingOperation();

      _iconKey.currentState.onAnimationDone = () {
        _idleIconSettingOperation = CancelableOperation.fromFuture(
          Future.delayed(const Duration(seconds: 2), () {
            _iconKey.currentState.onAnimationDone = () {
              _idleIconSettingOperation = null;
              _iconKey.currentState.onAnimationDone = null;
            };

            _iconColor = AppColors.accentColor;
            _iconKey.currentState.changeIcon(
              widget.idleIcon,
              AppColors.accentColor,
            );

            setState(() {
              _iconTitleVisibility = true;
            });

            _setIdleBackground();
          }),
        );
      };

      setState(() {
        _iconTitleVisibility = false;
      });

      _iconKey.currentState.changeIcon(widget.doneIcon, AppColors.processColor);
    } else {
      if (_iconKey.currentState.onAnimationDone == null) {
        _iconKey.currentState.changeIcon(widget.idleIcon, AppColors.accentColor);

        _setIdleBackground();
      }
    }
  }

  void _setIdleBackground() {
    final Color color = AppColors.lightenAccentColor;

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

  List<Offset> _points;
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
    final bool isProcess = _progress > 0 && _progress < 1.0;
    Path path;

    if (isProcess) {
      if (_points == null || size.width > _points.length - 3) {
        _points = List.filled(size.width.toInt() + 3, null);
      }

      for (double x = 0; x <= size.width; x++) {
        _points[x.toInt()] = Offset(
          x,
          1.5 * sin(x / (8 + _scale) + _position) + size.height * (1 - _progress),
        );
      }

      _points[size.width.toInt() + 1] = Offset(size.width, size.height);
      _points[size.width.toInt() + 2] = Offset(0, size.height);

      path = Path();
      path.addPolygon(_points, true);
      path.close();
    }

    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    final clipRect = RRect.fromRectAndCorners(
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
    final _Aquarium old = oldDelegate as _Aquarium;

    return old._progress != _progress || old._position != _position || old._scale != _scale;
  }
}
