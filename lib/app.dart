import 'package:droply/auth/auth_screen.dart';
import 'package:droply/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Droply",
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                cursorColor: AppColors.blue),
            home: AuthScreen()));
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}
