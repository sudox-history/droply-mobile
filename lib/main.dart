import 'package:droply/auth/auth_screen.dart';
import 'package:droply/common/constants.dart';
import 'package:droply/common/navigation.dart';
import 'package:droply/main/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarDividerColor: null,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: "Droply",
        routes: {
          AppNavigation.AUTH_ROUTE_NAME: (context) => AuthScreen(),
          AppNavigation.MAIN_ROUTE_NAME: (context) => MainScreen(),
        },
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: AppColors.primaryIconsColor),
          tabBarTheme: TabBarTheme(
            labelColor: AppColors.blue,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: AppFonts.semibold,
              fontFamily: AppFonts.openSans,
            ),
            unselectedLabelColor: AppColors.hint1TextColor,
            indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.blue, width: 4)),
            unselectedLabelStyle: TextStyle(
              fontSize: 15,
              fontWeight: AppFonts.semibold,
              fontFamily: AppFonts.openSans,
            ),
          ),
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: AppColors.whiteColor,
            centerTitle: true,
            elevation: 0,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: AppColors.headerTextColor,
                fontSize: 18,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.bold,
              ),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cursorColor: AppColors.blue,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
