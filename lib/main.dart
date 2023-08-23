import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterbase/components/loading_blocker.dart';
import 'package:flutterbase/screens/onboarding/splash.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/localization.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return LoadingBlocker(child: GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ms'),
      ],
      translationsKeys: AppTranslation.translationsKeys,
      locale: Get.deviceLocale,
      fallbackLocale: Locale("en"),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: constants.appName,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: 12, right: 12),
        ),
        textTheme: TextTheme(
          bodyMedium: styles.defaultTextStyle,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          elevation: 0,
          color: constants.primaryColor,
          titleTextStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'SfProDisplayBold'),
          iconTheme: const IconThemeData(opacity: 0.4),
        ),
        primarySwatch: constants.primaryColor,
        scaffoldBackgroundColor: const Color(0xffffffff),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
              color: constants.primaryColor,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: SplashScreen(),
    ));
  }
}
