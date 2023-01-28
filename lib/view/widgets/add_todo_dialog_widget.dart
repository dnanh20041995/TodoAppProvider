import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controller/todo_provider.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/view/widgets/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({super.key});

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thêm ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            TodoFormWidget(
              onChangedTitle: (title) => setState(
                () => this.title = title,
              ),
              onChangedDescription: (description) => setState(
                () => this.description = description,
              ),
              onSavedTodo: addTodo,
            ),
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
          createdTime: DateTime.now(),
          id: DateTime.now().toString(),
          title: title,
          description: description);

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
