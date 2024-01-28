import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/model/todo.dart';
import 'package:todo_bloc/widget/simple_input.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  addTodo() {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              buttonTap: () {
                Todo newTodo = Todo(
                  title: edtTitle.text,
                  description: edtDescription.text,
                );
                context.read<TodoBloc>().add(OnAddTodo(todo: newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, "Success Add ToDo");
              },
              buttonTitle: "Add ToDo",
            )
          ],
        );
      },
    );
  }

  updateTodo(Todo todo, int index) {
    final edtTitle = TextEditingController(text: todo.title);
    final edtDescription = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              buttonTap: () {
                Todo newTodo = Todo(
                  title: edtTitle.text,
                  description: edtDescription.text,
                );
                context
                    .read<TodoBloc>()
                    .add(OnUpdateTodo(todo: newTodo, index: index));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, "Success Update ToDo");
              },
              buttonTitle: "Update ToDo",
            )
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(
            context, "Remove ToDo", "Yakin ingin menghapus ToDo ini?")
        .then((bool? value) {
      if (value ?? false) {
        context.read<TodoBloc>().add(OnRemoveTodo(index: index));
        DInfo.snackBarError(context, 'Success Remove ToDo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          List<Todo> list = state.todos;
          if (state is TodoInitial) return const SizedBox.shrink();
          if (list.isEmpty)
            return Center(
              child: Text("Kosong"),
            );
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              Todo item = list[index];
              return ListTile(
                // onTap: updateTodo(item, index),
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(item.title),
                subtitle: Text(item.description),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'update':
                        updateTodo(item, index);
                        break;
                      case 'remove':
                        removeTodo(index);
                        break;
                      default:
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'update',
                      child: Text("Update"),
                    ),
                    PopupMenuItem(
                      value: 'remove',
                      child: Text("Remove"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
