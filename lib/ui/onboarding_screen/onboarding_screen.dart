import 'package:flutter/material.dart';
import 'package:flutter_jarvis/ui/onboarding_screen/onboarding_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, model, child) => 
        Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Column(
                      children: [
                        _buildHeaderText(),
                        14.verticalSpace,
                        _buildDescriptionText(),
                      ],
                    ),
                  ),
        
                  Expanded(child: Center(child: _buildImage())),
        
                  Padding(
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: _buildButton(model),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Your AI Assistant',
      style: TextStyle(
        fontSize: 40.sp,
        color: Color(0xFF3369FF),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescriptionText() {
    return SizedBox(
      width: 300.w,
      child: Text(
        'Jarvis is an AI-powered assistant that allows you to ask questions and receive informative, well-structured articles instantly. It also features voice-enabled interaction for a seamless, hands-free experience.',
        style: TextStyle(fontSize: 16.sp),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'assets/images/onboarding_image.png',
      width: 380.w,
      fit: BoxFit.contain,
    );
  }

  Widget _buildButton(OnboardingViewModel model) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: model.onButtonTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3369FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_right_alt, color: Colors.white, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
