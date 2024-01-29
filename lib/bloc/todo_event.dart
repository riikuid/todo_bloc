part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class OnFetchTodo extends TodoEvent {}

class OnAddTodo extends TodoEvent {
  final Todo todo;

  OnAddTodo({required this.todo});
}

class OnRemoveTodo extends TodoEvent {
  final Todo todo;

  OnRemoveTodo({required this.todo});
}

class OnUpdateTodo extends TodoEvent {
  final Todo todo;
  final int index;

  OnUpdateTodo({required this.todo, required this.index});
}
