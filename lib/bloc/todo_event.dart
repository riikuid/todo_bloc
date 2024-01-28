part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class OnAddTodo extends TodoEvent {
  final Todo todo;

  OnAddTodo({required this.todo});
}

class OnRemoveTodo extends TodoEvent {
  final int index;

  OnRemoveTodo({required this.index});
}

class OnUpdateTodo extends TodoEvent {
  final Todo todo;
  final int index;

  OnUpdateTodo({required this.todo, required this.index});
}
