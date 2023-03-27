import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String title;
  final Color color;
  final Color gColor;
  final String iconUrl;

  CategoryModel({
    required this.color,
    required this.gColor,
    required this.iconUrl,
    required this.id,
    required this.title,
  });
}
