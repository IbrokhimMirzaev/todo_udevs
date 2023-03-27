import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_udevs/data/models/cached_model.dart';
import 'package:todo_udevs/data/repos/category_repo.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

import '../../utils/assets.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.cachedTodo,
    required this.myDay,
  }) : super(key: key);

  final CachedModel cachedTodo;
  final bool myDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (myDay)
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 30.h),
            child: Text(
              DateTime.now().difference(cachedTodo.dateTime).inDays == 0 ? "Today" : DateFormat.MMMEd().format(cachedTodo.dateTime),
              style: RubikFont.w500.copyWith(fontSize: 13.sp, color: const Color(0xFF8B87B3)),
            ),
          ),
        Slidable(
          key: ValueKey(cachedTodo.id),
          endActionPane: ActionPane(
            extentRatio: 0.28,
            motion: const ScrollMotion(),
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 35.w,
                  width: 35.w,
                  margin: EdgeInsets.only(right: 6.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC4CEF5),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.edit,
                      height: 16.h,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 35.w,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFCFCF),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.delete,
                      height: 16.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                    color: context
                        .read<CategoryRepository>()
                        .getCategoryColorById(cachedTodo.categoryId),
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
                Text(DateFormat.Hm().format(cachedTodo.dateTime),
                    style: RubikFont.w400.copyWith(
                        fontSize: 11.sp, color: const Color(0xFFC6C6C8))),
                SizedBox(width: 15.w),
                Expanded(
                  child: Text(
                    cachedTodo.title,
                    style: RubikFont.w500.copyWith(
                        fontSize: 14.sp, color: const Color(0xFF554E8F)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SvgPicture.asset(Assets.smallBell),
                SizedBox(width: 10.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
