import 'package:flutter/widgets.dart';
import 'package:flutter_jarvis/ui/home_screen/home_screen.dart';
import 'package:get/route_manager.dart';

class OnboardingViewModel extends ChangeNotifier {
  void onButtonTap() {
    Get.offAll(HomeScreen());
  }
}
