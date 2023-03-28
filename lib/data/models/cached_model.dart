class CachedFields {
  static const String tableName = "cached_todos";
  static const String id = "_id";
  static const String categoryId = "category_id";
  static const String title = "title";
  static const String dateTime = "date_time";
  static const String isDone = "is_done";
  static const String isBell = "is_bell";
}

class CachedModel {
  int? id;
  int categoryId;
  String title;
  DateTime dateTime;
  bool isDone;
  bool isBell;

  CachedModel({
    this.id,
    required this.categoryId,
    required this.title,
    required this.dateTime,
    required this.isDone,
    required this.isBell,
  });

  static CachedModel fromJson(Map<String, Object?> json) {
    return CachedModel(
      id: json[CachedFields.id] as int?,
      categoryId: json[CachedFields.categoryId] as int,
      title: json[CachedFields.title] as String,
      dateTime: DateTime.parse(json[CachedFields.dateTime] as String),
      isDone: json[CachedFields.isDone] as int == 1,
      isBell: json[CachedFields.isBell] as int == 1,
    );
  }

  CachedModel copyWith({
    int? id,
    int? categoryId,
    String? title,
    DateTime? dateTime,
    bool? isDone,
    bool? isBell,
    int? taskPriority,
  }) =>
      CachedModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        isDone: isDone ?? this.isDone,
        isBell: isBell ?? this.isBell,
      );

  Map<String, Object?> toJson() {
    return {
      CachedFields.id: id,
      CachedFields.categoryId: categoryId,
      CachedFields.title: title,
      CachedFields.dateTime: dateTime.toString(),
      CachedFields.isDone: isDone ? 1 : 0,
      CachedFields.isBell: isBell ? 1 : 0,
    };
  }

  @override
  String toString() {
    return '$categoryId, $title, $dateTime, $isDone, isbell = $isBell';
  }
}
