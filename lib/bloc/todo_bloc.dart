import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([], TodoStatus.init)) {
    on<OnFetchTodo>((event, emit) async {
      emit(TodoState(state.todos, TodoStatus.loading));
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(TodoState([Todo(title: "title", description: "description")],
          TodoStatus.success));
    });

    on<OnAddTodo>(addTodo);

    updateTodo();

    on<OnRemoveTodo>((event, emit) async {
      Todo todo = event.todo;

      List<Todo> newTodos = state.todos;
      newTodos.removeWhere((element) => element.hashCode == todo.hashCode);

      emit(TodoState(newTodos, TodoStatus.success));
    });
  }

  void updateTodo() {
    return on<OnUpdateTodo>((event, emit) async {
      int index = event.index;
      Todo updatedTodo = event.todo;

      List<Todo> newTodos = state.todos;
      newTodos[index] = updatedTodo;

      emit(TodoState(newTodos, TodoStatus.success));
    });
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState> emit) async {
    Todo todo = event.todo;

    emit(TodoState([
      ...state.todos,
      todo,
    ], TodoStatus.success));
  }
}
