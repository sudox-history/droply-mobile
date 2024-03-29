import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AuthScreenLayout extends MultiChildRenderObjectWidget {
  AuthScreenLayout({
    Key key,
    List<Widget> children,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _AuthScreenLayoutRender(context);
  }
}

class _AuthScreenLayoutRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _AuthScreenLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _AuthScreenLayoutParentData> {
  static const _horizontalMargin = 20;
  static const _bottomMargin = 20.0;
  static const _topMargin = 20.0;
  static const _middleMargin = 25.0;

  final BuildContext _context;

  _AuthScreenLayoutRender(this._context, {List<RenderBox> children}) {
    addAll(children);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _AuthScreenLayoutParentData) {
      child.parentData = _AuthScreenLayoutParentData();
    }
  }

  @override
  void performLayout() {
    final query = MediaQuery.of(_context);
    final maxHeight = query.size.height;
    final maxWidth = constraints.maxWidth - 2 * _horizontalMargin;
    final children = getChildrenAsList();

    final header = children.first;
    final headerSize = Size(maxWidth, double.infinity);
    final topPadding = query.viewPadding.top + _topMargin;
    header.layout(BoxConstraints.loose(headerSize), parentUsesSize: true);

    final _AuthScreenLayoutParentData headerParentData = header.parentData as _AuthScreenLayoutParentData;
    headerParentData.offset = Offset(constraints.maxWidth / 2 - header.size.width / 2, topPadding);

    final footer = children.last;
    final footerSize = Size(maxWidth, double.infinity);
    footer.layout(BoxConstraints.loose(footerSize), parentUsesSize: true);

    final _AuthScreenLayoutParentData footerParentData = footer.parentData as _AuthScreenLayoutParentData;
    footerParentData.offset = Offset(
      constraints.maxWidth / 2 - footerSize.width / 2,
      maxHeight - _bottomMargin - footer.size.height,
    );

    final freeHeight = maxHeight - topPadding - header.size.height - footer.size.height - _bottomMargin;

    if (freeHeight >= _middleMargin * 2) {
      size = Size(constraints.maxWidth, maxHeight);
    } else {
      size = Size(
        constraints.maxWidth,
        topPadding + header.size.height + _middleMargin * 2 + footer.size.height + _bottomMargin,
      );

      footerParentData.offset = Offset(
        constraints.maxWidth / 2 - footerSize.width / 2,
        size.height - _bottomMargin - footer.size.height,
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return 0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return 0;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return 0;
  }
}

class _AuthScreenLayoutParentData extends ContainerBoxParentData<RenderBox> {}
