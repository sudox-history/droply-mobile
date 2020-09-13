import 'package:droply/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Droply", home: AuthScreen());
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}