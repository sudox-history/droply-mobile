import 'package:droply/auth/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth/auth_screen.dart';
import 'constants.dart';

void main() {
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF000000),
          systemNavigationBarDividerColor: null,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: "Droply",
            routes: {"/auth": (context) => AuthScreen(), "/main": (context) => MainScreen()},
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity, cursorColor: AppColors.blue),
            home: AuthScreen()));
  }
}
