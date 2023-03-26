import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/utils/assets.dart';
import 'package:todo_udevs/utils/constants/color_const.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 204.h, // 106.h
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: ColorConst.myBlueGradient,
                        end: Alignment.topLeft,
                        begin: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 13.h,
                    left: 18.w,
                    right: 18.w,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          height: 106.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Today's Reminder", style: RubikFont.w500.copyWith(fontSize: 20.sp, color: ColorConst.white)),
                                  Text(
                                    "Meeting with client",
                                    style: RubikFont.w400.copyWith(
                                      fontSize: 11.sp,
                                      color: ColorConst.white,
                                    ),
                                  ),
                                  Text(
                                    "13:00 PM",
                                    style: RubikFont.w400.copyWith(
                                      fontSize: 11.sp,
                                      color: ColorConst.white,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(Assets.bell)
                            ],
                          ),
                        ),
                        Positioned(
                          top: 9.h,
                          right: 11.w,
                          child: SvgPicture.asset(Assets.close),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
