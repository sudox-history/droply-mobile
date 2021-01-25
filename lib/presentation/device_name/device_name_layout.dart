import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeviceNameScreenLayout extends MultiChildRenderObjectWidget {
  DeviceNameScreenLayout({
    Key key,
    List<Widget> children,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _DeviceNameScreenLayoutRender(context);
  }
}

class _DeviceNameScreenLayoutRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DeviceNameScreenLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _DeviceNameScreenLayoutParentData> {
  static const _horizontalMargin = 20;
  static const _bottomMargin = 20.0;
  static const _topMargin = 56.0;
  static const _middleMargin = 72.0;

  BuildContext _context;

  _DeviceNameScreenLayoutRender(this._context, {List<RenderBox> children}) {
    addAll(children);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _DeviceNameScreenLayoutParentData) {
      child.parentData = _DeviceNameScreenLayoutParentData();
    }
  }

  @override
  void performLayout() {
    var maxHeight = MediaQuery.of(_context).size.height;
    var maxWidth = constraints.maxWidth - 2 * _horizontalMargin;
    var children = getChildrenAsList();

    var header = children.first;
    var headerSize = Size(maxWidth, double.infinity);
    header.layout(BoxConstraints.loose(headerSize), parentUsesSize: true);

    _DeviceNameScreenLayoutParentData headerParentData = header.parentData;
    headerParentData.offset =
        Offset(constraints.maxWidth / 2 - header.size.width / 2, _topMargin);

    var footer = children.last;
    var footerSize = Size(maxWidth, double.infinity);
    footer.layout(BoxConstraints.loose(footerSize), parentUsesSize: true);

    _DeviceNameScreenLayoutParentData footerParentData = footer.parentData;
    footerParentData.offset = Offset(
      constraints.maxWidth / 2 - footerSize.width / 2,
      maxHeight - _bottomMargin - footer.size.height,
    );

    var middle = children[1];
    var middleSize = Size(maxWidth, double.infinity);
    middle.layout(BoxConstraints.loose(middleSize), parentUsesSize: true);

    _DeviceNameScreenLayoutParentData middleParentData = middle.parentData;

    var middleX = constraints.maxWidth / 2 - middle.size.width / 2;
    var freeHeight = maxHeight -
        _topMargin -
        header.size.height -
        middle.size.height -
        footer.size.height -
        _bottomMargin;

    if (freeHeight >= _middleMargin * 2) {
      middleParentData.offset = Offset(
        middleX,
        (footerParentData.offset.dy +
                    headerParentData.offset.dy +
                    header.size.height) /
                2 -
            middle.size.height / 2,
      );

      size = Size(constraints.maxWidth, maxHeight);
    } else {
      middleParentData.offset = Offset(
        middleX,
        headerParentData.offset.dy + header.size.height + _middleMargin,
      );

      footerParentData.offset = Offset(
        footerParentData.offset.dx,
        middleParentData.offset.dy + middle.size.height + _middleMargin,
      );

      size = Size(
        constraints.maxWidth,
        _topMargin +
            header.size.height +
            _middleMargin * 2 +
            middle.size.height +
            footer.size.height +
            _bottomMargin,
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(HitTestResult result, {Offset position}) {
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

class _DeviceNameScreenLayoutParentData extends ContainerBoxParentData<RenderBox> {}
