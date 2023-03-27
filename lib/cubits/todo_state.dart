part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final List<CachedModel> toDoModels;
  final Status status;
  final bool showReminder;

  const TodoState({
    required this.status,
    required this.toDoModels,
    this.showReminder = true,
  });

  TodoState copyWith({
    Status? status,
    List<CachedModel>? toDoModels,
    bool? showReminder,
  }) =>
      TodoState(
        toDoModels: toDoModels ?? this.toDoModels,
        status: status ?? this.status,
        showReminder: showReminder ?? this.showReminder,
      );

  @override
  List<Object> get props => [status, showReminder, toDoModels];
}
