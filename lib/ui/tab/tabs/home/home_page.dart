import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/cubits/todo_cubit.dart';
import 'package:todo_udevs/data/enum/status.dart';
import 'package:todo_udevs/ui/widgets/todo_item.dart';
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
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              return SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: state.showReminder ? 204.h : 0.h,
                pinned: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello Brenda", style: RubikFont.w400.copyWith(fontSize: 18.sp, color: Colors.white)),
                        Text(
                          "Today you have ${state.toDoModels.length} tasks",
                          style: RubikFont.w400.copyWith(fontSize: 18.sp, color: Colors.white),
                        ),
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
                        child: BlocBuilder<TodoCubit, TodoState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                SizedBox(height: 18.h),
                                state.showReminder == true
                                    ? Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            height: 106.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Today's Reminder",
                                                        style: RubikFont.w500
                                                            .copyWith(
                                                                fontSize: 20.sp,
                                                                color: ColorConst
                                                                    .white)),
                                                    Text(
                                                      "Meeting with client",
                                                      style: RubikFont.w400
                                                          .copyWith(
                                                        fontSize: 11.sp,
                                                        color: ColorConst.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "13:00 PM",
                                                      style: RubikFont.w400
                                                          .copyWith(
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
                                            child: InkWell(
                                              onTap: () {
                                                context
                                                    .read<TodoCubit>()
                                                    .changeToFalseRemainder();
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.close),
                                            ),
                                          )
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              var status = state.status;

              if (status == Status.SUCCESS) {
                if (state.toDoModels.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return TodoItem(
                        cachedTodo: state.toDoModels[index],
                        myDay: index == 0 || state.toDoModels[index].dateTime.difference(state.toDoModels[index - 1].dateTime).inDays > 0,
                      );
                    }, childCount: state.toDoModels.length),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.empty, width: 115.w),
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
                    ),
                  );
                }
              }

              if (status == Status.LOADING) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              return const SliverToBoxAdapter(
                  child: Text("Something went wrong"));
            },
          )
        ],
      ),
    );
  }
}
