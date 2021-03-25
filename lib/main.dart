import 'package:droply/constants.dart';
import 'package:droply/data/devices/devices_repository.dart';
import 'package:droply/data/devices/providers/test_devices_provider.dart';
import 'package:droply/data/entries/entries_repository.dart';
import 'package:droply/data/entries/providers/test_entries_provider.dart';
import 'package:droply/presentation/auth/auth_screen.dart';
import 'package:droply/presentation/common/app_bar.dart';
import 'package:droply/presentation/common/tab_bar.dart';
import 'package:droply/presentation/main/main_screen.dart';
import 'package:droply/presentation/settings/settings_screen.dart';
import 'package:droply/presentation/statistics/statistics_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => DevicesRepository(provider: TestDevicesProvider())),
          RepositoryProvider(create: (context) => EntriesRepository(provider: TestEntriesProvider())),
        ],
        child: MaterialApp(
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: "Droply",
          routes: {
            AppNavigation.authRouteName: (context) => AuthScreen(),
            AppNavigation.mainRouteName: (context) => MainScreen(),
            AppNavigation.settingsRouteName: (context) => SettingsScreen(),
            AppNavigation.statisticsRouteName: (context) => StatisticsScreen(),
          },
          theme: ThemeData(
            splashColor: AppColors.rippleEffectColor,
            highlightColor: AppColors.highlightButtonColor,
            scaffoldBackgroundColor: AppColors.backgroundColor,
            primaryIconTheme: const IconThemeData(
              color: AppColors.primaryIconsColor,
            ),
            tabBarTheme: const TabBarTheme(
              indicator: TabBarIndicator(),
              labelPadding: EdgeInsets.symmetric(
                horizontal: TabBarStyles.tabHorizontalPadding,
              ),
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
            appBarTheme: const AppBarTheme(
              brightness: Brightness.light,
              color: AppColors.backgroundColor,
              centerTitle: true,
              elevation: AppBarStyles.elevation,
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
            buttonTheme: const ButtonThemeData(
              splashColor: AppColors.rippleEffectColor,
              highlightColor: AppColors.highlightButtonColor,
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                primary: AppColors.onAccentColor,
                onSurface: AppColors.onAccentColor,
                backgroundColor: AppColors.accentColor,
                textStyle: const TextStyle(
                  fontFamily: AppFonts.openSans,
                  fontWeight: AppFonts.semibold,
                  fontSize: 16,
                ),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.accentColor),
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
