import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_udevs/utils/assets.dart';
import 'package:todo_udevs/utils/constants/color_const.dart';
import 'package:todo_udevs/utils/constants/route_names.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 62.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(Assets.onBoardingImg, height: 220.h),
            SizedBox(height: 80.h),
            Text(
              "Reminders made simple",
              style: RubikFont.w500.copyWith(color: ColorConst.C_554E8F),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteNames.tab);
              },
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: ColorConst.greenGr,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: RubikFont.w400.copyWith(fontSize: 15.sp, color: ColorConst.C_FCFCFC),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
