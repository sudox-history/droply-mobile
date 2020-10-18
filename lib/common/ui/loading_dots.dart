import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  final Color _dotColor;

  LoadingDots(this._dotColor);

  @override
  State<StatefulWidget> createState() => _LoadingDotsState(_dotColor);
}

class _LoadingDotsState extends State<LoadingDots> with TickerProviderStateMixin {
  final Color _dotColor;

  Animation _dotSizeAnimation;
  AnimationController _dotSizeAnimationController;

  _LoadingDotsState(this._dotColor);

  @override
  void initState() {
    super.initState();

    _dotSizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _dotSizeAnimation = Tween(begin: 2.5, end: 1.5).animate(_dotSizeAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _dotSizeAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _dotSizeAnimationController.forward();
        }
      });

    _dotSizeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: _dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(_dotColor, _dotSizeAnimation.value),
          ),
        ),
        SizedBox(width: 2),
        AnimatedBuilder(
          animation: _dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(_dotColor, _dotSizeAnimation.value),
          ),
        ),
        SizedBox(width: 2),
        AnimatedBuilder(
          animation: _dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(_dotColor, _dotSizeAnimation.value),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _dotSizeAnimationController.dispose();
    super.dispose();
  }
}

class _LoadingDotPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double _radius;

  _LoadingDotPainter(Color dotColor, this._radius) {
    _paint.color = dotColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset centerPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centerPoint, _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _LoadingDotPainter old = oldDelegate;
    return old._radius != _radius;
  }
}
