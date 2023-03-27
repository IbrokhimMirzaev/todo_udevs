import 'dart:ui';

import 'package:todo_udevs/data/models/category_model.dart';
import 'package:todo_udevs/utils/assets.dart';

class CategoryRepository {
  List<CategoryModel> categories = [
    CategoryModel(
      color: const Color(0xFFFFD506),
      gColor: const Color(0xFFFFEE9B).withOpacity(0.36),
      iconUrl: Assets.personal, id: 0, title: 'Personal',
    ),

    CategoryModel(
      color: const Color(0xFF5DE61A),
      gColor: const Color(0xFFB5FF9B).withOpacity(0.36),
      iconUrl: Assets.work, id: 1, title: 'Work',
    ),

    CategoryModel(
      color: const Color(0xFFD10263),
      gColor: const Color(0xFFFF9BCD).withOpacity(0.36),
      iconUrl: Assets.meeting, id: 2, title: 'Meeting',
    ),

    CategoryModel(
      color: const Color(0xFFF29130),
      gColor: const Color(0xFFFFD09B).withOpacity(0.36),
      iconUrl: Assets.shopping, id: 3, title: 'Shopping',
    ),

    // Party
    CategoryModel(
      color: const Color(0xFF3044F2),
      gColor: const Color(0xFF9BFFF8).withOpacity(0.36),
      iconUrl: Assets.party, id: 4, title: 'Party',
    ),

    // Study
    CategoryModel(
      color: const Color(0xFFBF0080),
      gColor: const Color(0xFFF59BFF).withOpacity(0.36),
      iconUrl: Assets.study, id: 5, title: 'Study',
    ),
  ];

  Color getCategoryColorById(int id) {
    return categories.where((element) => element.id == id).toList()[0].color;
  }

  String getCategoryNameById(int id) {
    return categories.where((element) => element.id == id).toList()[0].title;
  }
}
