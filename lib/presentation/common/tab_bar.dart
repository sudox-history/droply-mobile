import 'package:droply/constants.dart';
import 'package:flutter/material.dart';

class TabBarStyles {
  static const tabHorizontalPadding = 25.0;
}

class TabBarIndicator extends Decoration {
  const TabBarIndicator();

  @override
  BoxPainter createBoxPainter([void Function() onChanged]) => _TabBarIndicatorPainter();
}

class _TabBarIndicatorPainter extends BoxPainter {
  static const _horizontalPadding = 5.0;
  static const _borderRadius = 10.0;
  static const _height = 4;

  final Paint _paint = Paint();

  _TabBarIndicatorPainter() {
    _paint.color = AppColors.accentColor;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final y = offset.dy + configuration.size.height;
    final rect = Rect.fromPoints(
      Offset(offset.dx + TabBarStyles.tabHorizontalPadding - _horizontalPadding, y - _height),
      Offset(offset.dx + configuration.size.width - TabBarStyles.tabHorizontalPadding + _horizontalPadding, y),
    );

    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(_borderRadius),
      topRight: const Radius.circular(_borderRadius),
    );

    canvas.drawRRect(rrect, _paint);
  }
}
