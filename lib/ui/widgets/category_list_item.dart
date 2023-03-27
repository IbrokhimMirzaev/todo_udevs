import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_udevs/data/models/category_model.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

class CategItem extends StatelessWidget {
  const CategItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.5.w),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: isSelected
            ? Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 11.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: category.color,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                      color: category.color.withOpacity(0.33),
                    )
                  ],
                ),
                child: Text(
                  category.title,
                  style: RubikFont.w400.copyWith(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: onPressed,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 10.w,
                      margin: EdgeInsets.only(top: 4.h, right: 5.w),
                      decoration: BoxDecoration(
                        color: category.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      category.title,
                      style: RubikFont.w400.copyWith(
                        fontSize: 15.sp,
                        color: const Color(0xFF8E8E8E),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onPressed;
}
