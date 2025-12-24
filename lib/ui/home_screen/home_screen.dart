import 'package:flutter/material.dart';
import 'package:flutter_jarvis/core/enums/view_state.dart';
import 'package:flutter_jarvis/ui/home_screen/home_screen_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color(0xFFF5F7FA),
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            title: Text(
              'Jarvis AI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 22.sp,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.black87),
              onPressed: () {},
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.settings_outlined, color: Colors.black87),
                onPressed: () {},
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    if (model.generatedContent != null)
                      _buildResponseSection(model)
                    else
                      _buildGreetingCard(),
                    if (model.generatedContent == null) ...[
                      _buildHelperText(),
                      _buildSuggestionCard(
                        Colors.cyanAccent.shade100,
                        Icons.chat_bubble_outline,
                        'Claude AI Chat',
                        'Have intelligent conversations powered by Claude AI',
                      ),
                      _buildSuggestionCard(
                        Colors.purple.shade100,
                        Icons.mic_none,
                        'Voice Assistant',
                        'Speak naturally and get instant AI responses',
                      ),
                      _buildSuggestionCard(
                        Colors.blue.shade100,
                        Icons.lightbulb_outline,
                        'Smart Help',
                        'Ask anything and get helpful, accurate answers',
                      ),
                    ],

                    100.verticalSpace,  
                  ],
                ),
              ),
              if (model.isListening)
                Positioned(
                  bottom: 100.h,
                  left: 0,
                  right: 0,
                  child: _buildListeningIndicator(model),
                ),

              if (model.state == ViewState.busy)
                Positioned(
                  bottom: 100.h,
                  left: 0,
                  right: 0,
                  child: _buildLoadingIndicator(),
                ),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
            child: FloatingActionButton.extended(
              onPressed: () async {
                if (!model.speechToText.isAvailable) {
                  await model.initSpeechToText();
                } else if (model.isListening) {
                  await model.stopListening();
                } else {
                  await model.startListening();
                }
              },
              backgroundColor: model.isListening
                  ? Colors.red.shade400
                  : Colors.cyanAccent.shade400,
              elevation: 4,
              icon: Icon(
                model.isListening ? Icons.stop : Icons.mic,
                color: Colors.black87,
              ),
              label: Text(
                model.isListening ? 'Stop' : 'Speak',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF3369FF), Color(0xFF3369FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3369FF).withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset('assets/images/splash_image.png', fit: BoxFit.contain,)
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Good Morning! 👋',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          10.verticalSpace,
          Text(
            'How can I assist you today?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseSection(HomeScreenViewModel model) {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h, left: 50.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.shade100,
                borderRadius: BorderRadius.circular(
                  15.r,
                ).copyWith(bottomRight: Radius.zero),
              ),
              child: Text(
                model.lastWords.isNotEmpty
                    ? model.lastWords
                    : 'Your question...',
                style: TextStyle(fontSize: 15.sp, color: Colors.black87),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(right: 50.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  15.r,
                ).copyWith(bottomLeft: Radius.zero),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                model.generatedContent!,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelperText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
      alignment: Alignment.centerLeft,
      child: Text(
        'Features',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(
    Color color,
    IconData icon,
    String headerText,
    String descriptionText,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 30.sp, color: Colors.black87),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headerText,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.verticalSpace,
                Text(
                  descriptionText,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningIndicator(HomeScreenViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.red.shade200, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic, color: Colors.red, size: 24.sp),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Listening...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.red.shade700,
                  ),
                ),
                if (model.lastWords.isNotEmpty) ...[
                  5.verticalSpace,
                  Text(
                    model.lastWords,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
            ),
          ),
          15.horizontalSpace,
          Text(
            'Thinking...',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
