import 'package:flutter/material.dart';
import 'package:flutter_jarvis/ui/splash_screen/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Color(0xFF3369FF),
            body: Center(child: Image.asset('assets/images/splash_image.png')),
          );
        },
      ),
    );
  }
}
