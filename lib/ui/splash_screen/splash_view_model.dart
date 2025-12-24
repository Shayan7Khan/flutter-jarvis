import 'package:flutter/widgets.dart';
import 'package:flutter_jarvis/ui/onboarding_screen/onboarding_screen.dart';
import 'package:get/route_manager.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    initialSetup();
  }

  void initialSetup() async{
  await Future.delayed(Duration(seconds: 3));
    Get.offAll(OnboardingScreen());
  }
}
