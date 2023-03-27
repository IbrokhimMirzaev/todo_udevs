import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/cubits/todo_cubit.dart';
import 'package:todo_udevs/data/models/cached_model.dart';
import 'package:todo_udevs/data/models/category_model.dart';
import 'package:todo_udevs/data/repos/category_repo.dart';
import 'package:todo_udevs/ui/widgets/category_list_item.dart';
import 'package:todo_udevs/ui/widgets/custom_text_field.dart';
import 'package:todo_udevs/ui/widgets/my_paint.dart';
import 'package:todo_udevs/utils/assets.dart';
import 'package:todo_udevs/utils/constants/color_const.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';
import 'package:todo_udevs/utils/utils.dart';

class MyModalBottomSheet extends StatefulWidget {
  MyModalBottomSheet({Key? key, this.cachedTodo}) : super(key: key);

  CachedModel? cachedTodo;

  @override
  State<MyModalBottomSheet> createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  TextEditingController controller = TextEditingController();
  List<CategoryModel> categories = [];
  int selectedCategId = -1;
  DateTime? pickedDate;

  @override
  void initState() {
    categories = context.read<CategoryRepository>().categories;

    if (widget.cachedTodo != null) {
      selectedCategId = widget.cachedTodo!.categoryId;
      pickedDate = widget.cachedTodo!.dateTime;
      controller.text = widget.cachedTodo!.title;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            width: 375.w,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  painter: MyPaint(),
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),
                      Center(
                          child: Text("Add new task",
                              style: RubikFont.w500.copyWith(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF404040)))),
                      CustomTextField(controller: controller),
                      SizedBox(height: 22.h),
                      SizedBox(
                        height: 30.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          children: List.generate(
                            categories.length,
                            (index) => CategItem(
                              category: categories[index],
                              isSelected:
                                  categories[index].id == selectedCategId,
                              onPressed: () => setState(() {
                                selectedCategId = categories[index].id;
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.5.w),
                        child:
                            Container(color: ColorConst.cCFCFCF, height: 1.h),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.only(left: 22.w),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () async {
                                DateTime? dateTime =
                                    await Utils.getDate(context: context);
                                if (dateTime == null) {
                                  Utils.getMyToast(
                                      message: 'Please choose the exact date');
                                } else {
                                  setState(() {
                                    pickedDate = dateTime;
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r)),
                                backgroundColor: Colors.transparent,
                              ),
                              child: Text(
                                "Choose date",
                                style: RubikFont.w400.copyWith(
                                  fontSize: 13.sp,
                                  color: ColorConst.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          var todo = CachedModel(
                            categoryId: selectedCategId,
                            title: controller.text,
                            dateTime: pickedDate!,
                            isDone: false,
                          );

                          if (todo.dateTime.toString().isNotEmpty) {
                            if (todo.categoryId != -1) {
                              if (todo.title.isNotEmpty) {
                                if (widget.cachedTodo == null) {
                                  context.read<TodoCubit>().addTodo(todo: todo);
                                }
                                else {
                                  context.read<TodoCubit>().editTodo(newTodo: todo);
                                }
                                Navigator.pop(context);
                              } else {
                                Utils.getMyToast(message: "Type the title of your todo!");
                              }
                            } else {
                              Utils.getMyToast(message: "Select one category!");
                            }
                          } else {
                            Utils.getMyToast(message: "Select date!");
                          }
                        },
                        child: Container(
                          height: 53.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 26.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            gradient: LinearGradient(
                              colors: ColorConst.myBlueGradient,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 6,
                                color: Color(0xFF6894EE),
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.cachedTodo != null
                                  ? "Edit task"
                                  : "Add task",
                              style: RubikFont.w500.copyWith(
                                fontSize: 18.sp,
                                color: ColorConst.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  right: 0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 10.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 53.h,
                      height: 53.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: ColorConst.pinkGr),
                      ),
                      child: Center(
                        child: SvgPicture.asset(Assets.bigClose),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
