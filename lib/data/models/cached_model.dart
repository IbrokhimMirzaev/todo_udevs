class CachedFields {
  static const String tableName = "cached_todos";
  static const String id = "_id";
  static const String categoryId = "category_id";
  static const String title = "title";
  static const String dateTime = "date_time";
  static const String isDone = "is_done";
}

class CachedModel {
  int? id;
  int categoryId;
  String title;
  DateTime dateTime;
  bool isDone;

  CachedModel({
    this.id,
    required this.categoryId,
    required this.title,
    required this.dateTime,
    required this.isDone,
  });

  static CachedModel fromJson(Map<String, Object?> json) {
    return CachedModel(
      id: json[CachedFields.id] as int?,
      categoryId: json[CachedFields.categoryId] as int,
      title: json[CachedFields.title] as String,
      dateTime: DateTime.parse(json[CachedFields.dateTime] as String),
      isDone: json[CachedFields.isDone] as int == 1,
    );
  }

  CachedModel copyWith({
    int? id,
    int? categoryId,
    String? title,
    DateTime? dateTime,
    bool? isDone,
    int? taskPriority,
  }) =>
      CachedModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        isDone: isDone ?? this.isDone,
      );

  Map<String, Object?> toJson() {
    return {
      CachedFields.id: id,
      CachedFields.categoryId: categoryId,
      CachedFields.title: title,
      CachedFields.dateTime: dateTime.toString(),
      CachedFields.isDone: isDone ? 1 : 0,
    };
  }
}
