import 'package:droply/common/constants.dart';
import 'package:droply/common/ui/aquarium.dart';
import 'package:droply/common/ui/loading_dots.dart';
import 'package:droply/state/progress.dart';
import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {
  final String _name;
  final String _description;
  final Color _primaryColor;
  final Color _backgroundColor;
  final Color _liquidColor;
  final IconData _icon;
  final String _iconTitle;
  final Progress _progress;
  final bool _showDots;
  final Function _buttonCallback;
  final String _counter;

  DeviceWidget(
    this._name,
    this._description,
    this._primaryColor,
    this._backgroundColor,
    this._liquidColor,
    this._icon,
    this._iconTitle,
    this._progress,
    this._showDots,
    this._buttonCallback,
    this._counter,
  );

  @override
  Widget build(BuildContext context) {
    Color descriptionColor;

    if (_showDots) {
      descriptionColor = _primaryColor;
    } else {
      descriptionColor = AppColors.secondaryTextColor;
    }

    var descriptionBlock = <Widget>[
      Text(
        _description,
        style: TextStyle(
          color: descriptionColor,
          fontFamily: AppFonts.openSans,
          fontWeight: AppFonts.semibold,
          fontSize: 15,
        ),
      ),
    ];

    if (_showDots) {
      descriptionBlock.add(SizedBox(width: 5));
      descriptionBlock.add(LoadingDots(_primaryColor));
    }

    var children = [
      Container(
        child: Aquarium(
          _backgroundColor,
          _liquidColor,
          _primaryColor,
          _icon,
          _iconTitle,
          _progress,
        ),
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
                  color: AppColors.onSurfaceColor,
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.semibold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: descriptionBlock,
              )
            ],
          ),
        ),
      )
    ];

    if (_counter != null) {
      children.add(
        Text(
          _counter,
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppFonts.openSans,
            fontWeight: AppFonts.regular,
            color: AppColors.hintTextColor,
          ),
        ),
      );
    }

    var rightPadding = 16.0;

    if (_buttonCallback != null) {
      children.add(IconButton(
        padding: EdgeInsets.all(20),
        color: AppColors.onSurfaceColor,
        icon: Icon(Icons.more_vert),
        onPressed: _buttonCallback,
      ));

      rightPadding = 0;
    }

    return Padding(
      padding: EdgeInsets.only(
        top: 7.5,
        bottom: 7.5,
        right: rightPadding,
        left: 16,
      ),
      child: Row(children: children),
    );
  }
}
