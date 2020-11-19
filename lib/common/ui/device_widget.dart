import 'package:droply/common/constants.dart';
import 'package:droply/common/ui/aquarium.dart';
import 'package:droply/common/ui/loading_dots.dart';
import 'package:droply/main/nearby_screen.dart';
import 'package:droply/state/progress/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DeviceWidget extends StatelessWidget {
  final String _name;
  final String _description;
  final Color _primaryColor;
  final Color _backgroundColor;
  final Color _liquidColor;
  final IconData _icon;

  Progress progress = Progress();

  DeviceWidget(
    this._name,
    this._description,
    this._primaryColor,
    this._backgroundColor,
    this._liquidColor,
    this._icon,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
      child: Row(
        children: [
          Container(
            child:
                Aquarium(_backgroundColor, _liquidColor, _primaryColor, _icon, progress),
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
                      LoadingDots(AppColors.processColor)
                    ],
                  )
                ],
              ),
            ),
          ),
          IconButton(
            color: AppColors.onSurfaceColor,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
