import 'package:flutter/material.dart';
import 'package:flutter_jarvis/ui/home_screen/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const double _designWidth = 430;
  static const double _designHeight = 932;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(_designWidth, _designHeight),
      child: GetMaterialApp(title: 'Flutter Jarvis', home: HomeScreen()),
    );
  }
}
