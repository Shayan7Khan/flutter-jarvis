import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_jarvis/core/logger_customizations/custom_logger.dart';
import 'package:flutter_jarvis/locator.dart';
import 'package:flutter_jarvis/ui/home_screen/home_screen.dart';
import 'package:flutter_jarvis/ui/splash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

void main() async {
  final log = CustomLogger(className: 'main');
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.f('Testing fatal logs');
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      log.e('Failed to load .env file: $e');
    }
    setUpLocator();
    runApp(const MyApp());
  } catch (e, s) {
    log.d('$e');
    log.d('$s');
  }
}

class MyApp extends StatelessWidget {
  static const double _designWidth = 430;
  static const double _designHeight = 932;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(_designWidth, _designHeight),
      child: GetMaterialApp(title: 'Flutter Jarvis', home: SplashScreen()),
    );
  }
}
