import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/data/models/category_model.dart';
import 'package:todo_udevs/data/repos/category_repo.dart';
import 'package:todo_udevs/utils/assets.dart';
import 'package:todo_udevs/utils/constants/color_const.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = context.read<CategoryRepository>().categories;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 204.h,
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello Brenda", style: RubikFont.w400.copyWith(fontSize: 18.sp, color: Colors.white)),
                    Text("Today you have 9 tasks",
                        style: RubikFont.w400
                            .copyWith(fontSize: 18.sp, color: Colors.white)),
                  ],
                ),
                const CircleAvatar(backgroundColor: Colors.white)
              ],
            ),
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
                    child: Column(
                      children: [
                        SizedBox(height: 18.h),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              height: 106.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Today's Reminder",
                                          style: RubikFont.w500.copyWith(
                                              fontSize: 20.sp,
                                              color: ColorConst.white)),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 31.h),
            sliver: SliverGrid.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 22.w,
                mainAxisSpacing: 30.w,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFBBBBBB).withOpacity(0.5),
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: categories[index].gColor,
                        ),
                        child: Center(child: SvgPicture.asset(categories[index].iconUrl)),
                      ),
                      SizedBox(height: 7.h),
                      Text(categories[index].title, style: RubikFont.w500.copyWith(fontSize: 17.sp, color: const Color(0xFF686868))),
                      SizedBox(height: 15.h),
                      Text("24 Tasks", style: RubikFont.w400.copyWith(fontSize: 10.sp, color: const Color(0xFFA1A1A1))),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50.h))
        ],
      ),
    );
  }
}
