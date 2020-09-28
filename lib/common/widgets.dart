import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';

class TabBarStyles {
  static const tabHorizontalPadding = 25.0;
}

class TabBarIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _TabBarIndicatorPainter();
  }
}

class _TabBarIndicatorPainter extends BoxPainter {
  static const _horizontalPadding = 5.0;
  static const _borderRadius = 10.0;
  static const _height = 4;

  Paint _paint = Paint();

  _TabBarIndicatorPainter() {
    _paint.color = AppColors.blue;
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var y = offset.dy + configuration.size.height;
    var rect = Rect.fromPoints(
      Offset(offset.dx + TabBarStyles.tabHorizontalPadding - _horizontalPadding, y - _height),
      Offset(offset.dx + configuration.size.width - TabBarStyles.tabHorizontalPadding + _horizontalPadding, y),
    );

    var rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(_borderRadius),
      topRight: Radius.circular(_borderRadius),
    );

    canvas.drawRRect(rrect, _paint);
  }
}
