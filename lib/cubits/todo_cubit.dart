import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_udevs/data/enum/status.dart';
import 'package:todo_udevs/data/models/cached_model.dart';
import 'package:todo_udevs/data/repos/category_repo.dart';
import 'package:todo_udevs/data/repos/my_repo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({required this.myTodoRepo, required this.categRepo})
      : super(
          const TodoState(
            status: Status.PURE,
            toDoModels: [],
          ),
        ) {
    getAllTodos();
  }

  final MyTodoRepo myTodoRepo;
  final CategoryRepository categRepo;

  Future<void> addTodo({required CachedModel todo}) async {
    await myTodoRepo.addCacheToDo(todo);
    getAllTodos();
  }

  Future<void> editTodo({required CachedModel newTodo}) async {
    print("UPDATE TODO: ${newTodo.toString()}");
    await myTodoRepo.updateCachedTodo(cachedTodo: newTodo);
    getAllTodos();
  }

  Future<void> deleteTodo({required int id}) async {
    await myTodoRepo.deleteCachedTodoById(id);
    getAllTodos();
  }

  Future<void> getAllTodos() async {
    emit(state.copyWith(status: Status.LOADING));
    var todos = await myTodoRepo.getAllToDos();
    emit(state.copyWith(status: Status.SUCCESS, toDoModels: todos));
  }

  void changeToFalseRemainder() {
    emit(state.copyWith(showReminder: false));
  }

  void changeDoneToTrue({required CachedModel cachedTodo}) {
    myTodoRepo.changeDoneToTrue(cachedTodo: cachedTodo);
    getAllTodos();
  }

  void changeDoneToFalse({required CachedModel cachedTodo}) {
    myTodoRepo.changeDoneToFalse(cachedTodo: cachedTodo);
    getAllTodos();
  }

  int getCountByCategory({required int cId}) {
    var count = 0;
    for (var todo in state.toDoModels) {
      if (todo.categoryId == cId) {
        count++;
      }
    }

    return count;
  }
}
