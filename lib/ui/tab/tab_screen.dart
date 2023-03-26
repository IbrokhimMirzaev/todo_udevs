import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_udevs/ui/tab/tabs/home/home_page.dart';
import 'package:todo_udevs/ui/tab/tabs/task/task_page.dart';
import 'package:todo_udevs/utils/assets.dart';
import 'package:todo_udevs/utils/constants/color_const.dart';
import 'package:todo_udevs/utils/constants/rubik_font.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const TaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 53.h,
          height: 53.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: ColorConst.pinkGr),
          ),
          child: Center(child: SvgPicture.asset(Assets.add)),
        ),
        onPressed: () {},
      ),
      resizeToAvoidBottomInset: false,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        elevation: 0.0,
        selectedItemColor: ColorConst.activeTabColor,
        unselectedItemColor: ColorConst.passiveTabColor,
        selectedLabelStyle: RubikFont.w500.copyWith(fontSize: 10.sp),
        unselectedLabelStyle: RubikFont.w500.copyWith(fontSize: 10.sp),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: ColorConst.white,
        items: [
          bottomNavItem(
            isSelected: _selectedIndex == 0,
            iconPath: Assets.home,
            label: 'Home',
          ),
          bottomNavItem(
            isSelected: _selectedIndex == 1,
            iconPath: Assets.task,
            label: 'Task',
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavItem({
  required bool isSelected,
  required String iconPath,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: SvgPicture.asset(
        iconPath,
        height: 28.h,
        color: isSelected ? ColorConst.activeTabColor : ColorConst.passiveTabColor,
      ),
    ),
    label: label,
  );
}
