import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:device_info/device_info.dart';
import 'package:droply/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      Offset(
          offset.dx +
              configuration.size.width -
              TabBarStyles.tabHorizontalPadding +
              _horizontalPadding,
          y),
    );

    var rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(_borderRadius),
      topRight: Radius.circular(_borderRadius),
    );

    canvas.drawRRect(rrect, _paint);
  }
}

class DeviceWidget extends StatelessWidget {
  final String _name;
  final String _description;
  final Color _primaryColor;
  final Color _backgroundColor;
  final Color _liquidColor;
  final IconData _icon;
  final double _progress;

  DeviceWidget(this._name, this._description, this._primaryColor, this._backgroundColor,
      this._liquidColor, this._icon, this._progress);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
      child: Row(
        children: [
          Container(
            child: _DeviceAquarium(_backgroundColor, _liquidColor, _primaryColor, _icon, _progress),
            margin: EdgeInsets.only(left: 20),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                      color: AppColors.labelTextColor,
                      fontFamily: AppFonts.openSans,
                      fontWeight: AppFonts.semibold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _description,
                        style: TextStyle(
                          color: _primaryColor,
                          fontFamily: AppFonts.openSans,
                          fontWeight: AppFonts.semibold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      LoadingDots(AppColors.green)
                    ],
                  )
                ],
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(20),
            color: AppColors.labelTextColor,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _DeviceAquarium extends StatefulWidget {
  final Color _backgroundColor;
  final Color _liquidColor;
  final Color _iconColor;
  final IconData _icon;
  final double _progress;

  _DeviceAquarium(
      this._backgroundColor, this._liquidColor, this._iconColor, this._icon, this._progress);

  @override
  State<StatefulWidget> createState() =>
      _DeviceAquariumState(_backgroundColor, _liquidColor, _iconColor, _icon, _progress);
}

class _DeviceAquariumState extends State<_DeviceAquarium> with TickerProviderStateMixin {
  AnimationController _wavePositionAnimationController;
  AnimationController _waveScaleAnimationController;
  Animation<double> _wavePositionAnimation;
  Animation<double> _waveScaleAnimation;
  final Color _backgroundColor;
  final Color _liquidColor;
  final Color _iconColor;
  final IconData _icon;
  final double _progress;

  _DeviceAquariumState(
      this._backgroundColor, this._liquidColor, this._iconColor, this._icon, this._progress);

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

    _waveScaleAnimationController.forward();
    _wavePositionAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedBuilder(
          animation: _wavePositionAnimation,
          builder: (context, snapshot) {
            return CustomPaint(
              size: Size.square(60),
              painter: _DeviceAquariumPainter(_liquidColor, _backgroundColor,
                  _waveScaleAnimation.value, _wavePositionAnimation.value, _progress),
            );
          },
        ),
        Icon(
          _icon,
          color: _iconColor,
        ),
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

class _DeviceAquariumPainter extends CustomPainter {
  static const _borderRadius = Radius.circular(15);

  Paint _paint = Paint();
  Color _backgroundColor;
  double _progress;
  double _scale;
  double _position;

  _DeviceAquariumPainter(
      Color color, this._backgroundColor, this._scale, this._position, this._progress) {
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var points = List<Offset>();

    for (double x = 0; x <= size.width; x++) {
      points.add(Offset(
        x,
        1.5 * sin((x) / (8 + _scale) + _position) + size.height * (1 - _progress),
      ));
    }

    points.add(Offset(size.width, size.height));
    points.add(Offset(0, size.height));

    var path = Path();
    var rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    var clipRect = RRect.fromRectAndCorners(
      rect,
      topRight: _borderRadius,
      topLeft: _borderRadius,
      bottomLeft: _borderRadius,
      bottomRight: _borderRadius,
    );

    path.addPolygon(points, true);
    canvas.clipRRect(clipRect);
    canvas.drawColor(_backgroundColor, BlendMode.src);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _DeviceAquariumPainter old = oldDelegate;

    return old._progress != _progress || old._position != _position || old._scale != _scale;
  }
}

class LoadingDots extends StatefulWidget {
  Color dotColor;

  LoadingDots(this.dotColor);

  @override
  State<StatefulWidget> createState() => _LoadingDotsState(dotColor);
}

class _LoadingDotsState extends State<LoadingDots> with TickerProviderStateMixin {
  Animation dotSizeAnimation;
  AnimationController dotSizeAnimationController;

  Color dotColor;

  _LoadingDotsState(this.dotColor);

  @override
  void initState() {
    super.initState();

    dotSizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    dotSizeAnimation = Tween(begin: 2.5, end: 1.5).animate(dotSizeAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          dotSizeAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          dotSizeAnimationController.forward();
        }
      });

    dotSizeAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(dotColor, dotSizeAnimation.value),
          ),
        ),
        SizedBox(width: 2),
        AnimatedBuilder(
          animation: dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(dotColor, dotSizeAnimation.value),
          ),
        ),
        SizedBox(width: 2),
        AnimatedBuilder(
          animation: dotSizeAnimation,
          builder: (context, snapshot) => CustomPaint(
            size: Size.square(5),
            painter: _LoadingDotPainter(dotColor, dotSizeAnimation.value),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    dotSizeAnimationController.dispose();
    super.dispose();
  }
}

class _LoadingDotPainter extends CustomPainter {
  Paint _paint = Paint();

  double radius;

  _LoadingDotPainter(Color dotColor, this.radius) {
    _paint.color = dotColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset centerPoint = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centerPoint, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyDevice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {

  var _deviceModel;
  var _isAndroid;

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

  @override
  Widget build(BuildContext context) {
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
}

class MyDeviceWidgets {
  static Widget buildNameHint() {
    return Text(
      "device_name_hint".tr(),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.hint1TextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.semibold,
        fontSize: 16,
      ),
    );
  }

  static Widget buildNameField([Function onChanged, bool hintAtStart = false, bool initialText]) {
    return TextField(
      style: TextStyle(
        color: AppColors.labelTextColor,
        fontFamily: AppFonts.openSans,
        fontWeight: AppFonts.bold,
        fontSize: 20,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(25)],
      onChanged: (text) {
        onChanged(AppRegex.deviceNameAllow.hasMatch(text));
      },
      textAlign: hintAtStart ? TextAlign.start : TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        hintText: "enter_device_name_hint".tr(),
        hintStyle: TextStyle(
          color: AppColors.hint2TextColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.regular,
          fontSize: 20,
        ),
        isDense: true,
      ),
    );
  }
}