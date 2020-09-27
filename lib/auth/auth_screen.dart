import 'dart:io';
import 'package:droply/constants.dart';
import 'package:droply/navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info/device_info.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  var _canStart = false;
  var _deviceModel;
  var _isAndroid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _AuthScreenLayout(
          children: [
            Column(
              children: [
                _buildWelcomeTitle(),
                _buildWelcomeHint(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDeviceBlock(),
                _buildDeviceNameHint(),
                _buildDeviceNameField(),
              ],
            ),
            Column(
              children: [
                _buildLicenseText(),
                _buildStartSharingButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  void _getDeviceInfo() async {
    var info = DeviceInfoPlugin();
    var model;

    if (Platform.isAndroid) {
      _isAndroid = true;
      model = (await info.androidInfo).model;
    } else if (Platform.isIOS) {
      _isAndroid = false;
      model = (await info.iosInfo).model;
    }

    setState(() {
      _deviceModel = model;
    });
  }

  Widget _buildWelcomeTitle() {
    return Text(
      "welcome_title".tr(),
      style: TextStyle(
        color: AppColors.headerTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildWelcomeHint() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "welcome_hint".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.hint1TextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildLicenseText() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColors.hint1TextColor,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.regular,
            fontSize: 15,
          ),
          children: [
            TextSpan(text: "agreement1".tr()),
            TextSpan(
              text: "agreement2".tr(),
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: AppFonts.semibold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  const url = "https://flutter.io";
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartSharingButton() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      width: double.infinity,
      child: FlatButton(
        color: AppColors.blue,
        disabledColor: AppColors.hint2TextColor,
        padding: EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: _canStart ? () {
          Navigator.pushReplacementNamed(context, Navigation.MAIN_ROUTE_NAME);
        } : null,
        child: Text(
          "enter_button".tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.semibold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceBlock() {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _deviceModel != null
            ? [
                Icon(
                  _isAndroid ? Icons.phone_android : Icons.phone_iphone,
                  color: AppColors.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Text(
                    _deviceModel,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.blue,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.semibold,
                      fontSize: 16,
                    ),
                  ),
                )
              ]
            : [
                SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
              ],
      ),
    );
  }

  Widget _buildDeviceNameHint() {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "device_name_hint".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.hint1TextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.semibold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDeviceNameField() {
    return TextField(
      style: TextStyle(
        color: AppColors.labelTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.regular,
        fontSize: 20,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(25)],
      onChanged: (text) {
        setState(() {
          _canStart = Regex.deviceNameAllow.hasMatch(text);
        });
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "enter_device_name_hint".tr(),
        hintStyle: TextStyle(
          color: AppColors.hint2TextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 20,
        ),
      ),
    );
  }
}

class _AuthScreenLayout extends MultiChildRenderObjectWidget {
  _AuthScreenLayout({
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
  static const _topMargin = 56.0;
  static const _middleMargin = 72.0;

  BuildContext _context;

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
    var maxHeight = MediaQuery.of(_context).size.height;
    var maxWidth = constraints.maxWidth - 2 * _horizontalMargin;
    var children = getChildrenAsList();

    var header = children.first;
    var headerSize = Size(maxWidth, double.infinity);
    header.layout(BoxConstraints.loose(headerSize), parentUsesSize: true);

    _AuthScreenLayoutParentData headerParentData = header.parentData;
    headerParentData.offset = Offset(constraints.maxWidth / 2 - header.size.width / 2, _topMargin);

    var footer = children.last;
    var footerSize = Size(maxWidth, double.infinity);
    footer.layout(BoxConstraints.loose(footerSize), parentUsesSize: true);

    _AuthScreenLayoutParentData footerParentData = footer.parentData;
    footerParentData.offset = Offset(
      constraints.maxWidth / 2 - footerSize.width / 2,
      maxHeight - _bottomMargin - footer.size.height,
    );

    var middle = children[1];
    var middleSize = Size(maxWidth, double.infinity);
    middle.layout(BoxConstraints.loose(middleSize), parentUsesSize: true);

    _AuthScreenLayoutParentData middleParentData = middle.parentData;
    var middleX = constraints.maxWidth / 2 - middle.size.width / 2;
    var freeHeight =
        maxHeight - _topMargin - header.size.height - middle.size.height - footer.size.height - _bottomMargin;

    if (freeHeight >= _middleMargin * 2) {
      middleParentData.offset = Offset(
        middleX,
        (footerParentData.offset.dy + headerParentData.offset.dy + header.size.height) / 2 - middle.size.height / 2,
      );

      size = Size(constraints.maxWidth, maxHeight);
    } else {
      middleParentData.offset = Offset(
        middleX,
        headerParentData.offset.dy + header.size.height + _middleMargin,
      );

      footerParentData.offset =
          Offset(footerParentData.offset.dx, middleParentData.offset.dy + middle.size.height + _middleMargin);

      size = Size(
        constraints.maxWidth,
        _topMargin + header.size.height + _middleMargin * 2 + middle.size.height + footer.size.height + _bottomMargin,
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

class _AuthScreenLayoutParentData extends ContainerBoxParentData<RenderBox> {}
