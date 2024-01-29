import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {
    on<OnAddTodo>(addTodo);

    updateTodo();

    on<OnRemoveTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(const Duration(milliseconds: 1500));

      Todo todo = event.todo;

      List<Todo> newTodos = state.todos;
      newTodos.removeWhere((element) => element.hashCode == todo.hashCode);

      emit(TodoRemoved(newTodos));
    });
  }

  void updateTodo() {
    return on<OnUpdateTodo>((event, emit) async {
      emit(TodoLoading(state.todos));
      await Future.delayed(const Duration(milliseconds: 1500));

      int index = event.index;
      Todo updatedTodo = event.todo;

      List<Todo> newTodos = state.todos;
      newTodos[index] = updatedTodo;

      emit(TodoRemoved(newTodos));
    });
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading(state.todos));
    await Future.delayed(const Duration(milliseconds: 1500));

    Todo todo = event.todo;

    emit(TodoAdded([
      ...state.todos,
      todo,
    ]));
  }
}
