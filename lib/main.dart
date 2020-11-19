import 'package:droply/auth/auth_screen.dart';
import 'package:droply/common/constants.dart';
import 'package:droply/common/navigation.dart';
import 'package:droply/common/ui/tab_bar.dart';
import 'package:droply/main/main_screen.dart';
import 'package:droply/statistics/statistics_screen.dart';
import 'package:droply/settings/settings_screen.dart';
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
          AppNavigation.authRouteName: (context) => AuthScreen(),
          AppNavigation.mainRouteName: (context) => MainScreen(),
          AppNavigation.settingsRouteName: (context) => SettingsScreen(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primaryIconTheme: IconThemeData(color: AppColors.primaryIconsColor),
          tabBarTheme: TabBarTheme(
            labelPadding: EdgeInsets.symmetric(horizontal: TabBarStyles.tabHorizontalPadding),
            indicator: TabBarIndicator(),
            labelColor: AppColors.accentColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: AppFonts.semibold,
              fontFamily: AppFonts.openSans,
            ),
            unselectedLabelColor: AppColors.secondaryTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 15,
              fontWeight: AppFonts.semibold,
              fontFamily: AppFonts.openSans,
            ),
          ),
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: AppColors.backgroundColor,
            centerTitle: true,
            elevation: 0.5,
            shadowColor: AppColors.dividerColor,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 18,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.bold,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              primary: AppColors.onAccentColor,
              onSurface: AppColors.onAccentColor,
              backgroundColor: AppColors.accentColor,
              textStyle: TextStyle(
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                fontSize: 16,
              )
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cursorColor: AppColors.accentColor,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
