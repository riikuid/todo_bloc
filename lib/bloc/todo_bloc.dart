import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {
    on<OnAddTodo>((event, emit) {
      Todo todo = event.todo;
      emit(TodoAdded([
        ...state.todos,
        todo,
      ]));
    });

    on<OnRemoveTodo>((event, emit) {
      int index = event.index;

      List<Todo> newTodos = state.todos;
      newTodos.removeAt(index);

      emit(TodoRemoved(newTodos));
    });

    on<OnUpdateTodo>((event, emit) {
      int index = event.index;
      Todo updatedTodo = event.todo;

      List<Todo> newTodos = state.todos;
      newTodos[index] = updatedTodo;

      emit(TodoRemoved(newTodos));
    });
  }
}
