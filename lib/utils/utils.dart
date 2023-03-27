import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static getMyToast({required String message}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_RIGHT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.lightBlue,
    textColor: Colors.white,
    fontSize: 16.sp,
  );

  static Future<DateTime?> getDate({required BuildContext context}) async {
    DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year), lastDate: DateTime(DateTime.now().year + 1));
    // ignore: use_build_context_synchronously
    TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (date == null || timeOfDay == null) return null;
    return DateTime(date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);
  }
}