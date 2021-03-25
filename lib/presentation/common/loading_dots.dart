import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  final Color _dotColor;

  const LoadingDots(
    this._dotColor,
  );

  @override
  State<StatefulWidget> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> with TickerProviderStateMixin {
  Animation<double> _dotSizeAnimation;
  AnimationController _dotSizeAnimationController;

  @override
  void initState() {
    super.initState();

    _dotSizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _dotSizeAnimation = Tween(begin: 2.5, end: 1.5).animate(_dotSizeAnimationController)
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
    return AnimatedBuilder(
      animation: _dotSizeAnimation,
      builder: (context, _) {
        return Row(
          children: [
            CustomPaint(
              size: const Size.square(5),
              painter: _LoadingDotPainter(widget._dotColor, _dotSizeAnimation.value),
            ),
            const SizedBox(width: 2),
            CustomPaint(
              size: const Size.square(5),
              painter: _LoadingDotPainter(widget._dotColor, _dotSizeAnimation.value),
            ),
            const SizedBox(width: 2),
            CustomPaint(
              size: const Size.square(5),
              painter: _LoadingDotPainter(widget._dotColor, _dotSizeAnimation.value),
            ),
          ],
        );
      },
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
    final Offset centerPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centerPoint, _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _LoadingDotPainter old = oldDelegate as _LoadingDotPainter;
    return old._radius != _radius;
  }
}
