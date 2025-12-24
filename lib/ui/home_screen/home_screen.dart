import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text('Jarvis'),
          leading: Icon(Icons.menu),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildHeaderImage(),
            _buildGreetingCard(),
            _buildHelperText(),
            _buildsuggestionCard(Colors.cyanAccent, 'ChatGPT', 'A smarter way to stay organized, A smarter way to stay organized, A smarter way to stay organized'),
            _buildsuggestionCard(Colors.lightGreen, 'DALL-E', 'A smarter way to stay organized, A smarter way to stay organized, A smarter way to stay organized, '),
            _buildsuggestionCard(Colors.lightBlueAccent, 'IDK', 'A smarter way to stay organized, A smarter way to stay organized, A smarter way to stay organized',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: Container(
        height: 150.h,
        width: 150.w,
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF3369FF),
          image: DecorationImage(
            image: AssetImage('assets/images/splash_image.png'),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: 40.w,
      ).copyWith(top: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20.r,
        ).copyWith(topLeft: Radius.zero),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          'Good Morning, What task can I do for you?',
          style: TextStyle(color: Colors.black, fontSize: 25.sp),
        ),
      ),
    );
  }

  Widget _buildHelperText() {
    return Container(
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.only(top: 10.h, left: 22.w),
      alignment: Alignment.centerLeft,
      child: Text(
        'Here are few features',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
    );
  }

  Widget _buildsuggestionCard(
    Color color,
    String headerText,
    String descriptionText,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        
            Text(
              descriptionText,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
