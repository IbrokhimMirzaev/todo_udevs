import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/cubits/todo_cubit.dart';
import 'package:todo_udevs/data/enum/status.dart';
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
            expandedHeight: 204.h,
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello Brenda",
                        style: RubikFont.w400
                            .copyWith(fontSize: 18.sp, color: Colors.white)),
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
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              var status = state.status;

              if (status == Status.SUCCESS) {
                if (state.toDoModels.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 60.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD506),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  bottomLeft: Radius.circular(8.r),
                                ),
                              ),
                              width: 4,
                              height: double.infinity,
                            ),
                            SizedBox(width: 11.w),
                            SvgPicture.asset(Assets.emptyCircle),
                            SizedBox(width: 11.w),
                            Text("08.00 AM",
                                style: RubikFont.w400.copyWith(
                                    fontSize: 11.sp,
                                    color: const Color(0xFFC6C6C8))),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Text(
                                "Go jogging with Christin",
                                style: RubikFont.w500.copyWith(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF554E8F)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SvgPicture.asset(Assets.smallBell),
                            SizedBox(width: 10.w),
                          ],
                        ),
                      );
                    }, childCount: 30),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Image.asset(Assets.empty),
                        SizedBox(height: 70.h),
                        Text(
                          "No tasks",
                          style: RubikFont.w500.copyWith(
                            fontSize: 22.sp,
                            color: const Color(0xFF554E8F),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }

              if (status == Status.LOADING) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator.adaptive()));
              }

              return const SliverToBoxAdapter(child: Text("Something went wrong"));
            },
          )
        ],
      ),
    );
  }
}
