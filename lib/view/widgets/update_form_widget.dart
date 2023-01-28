import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controller/todo_provider.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/view/widgets/todo_form_widget.dart';

class UpdateTodo extends StatefulWidget {
  final Todo todo;
  const UpdateTodo({super.key, required this.todo});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              TodoFormWidget(
                title: title,
                description: description,
                onChangedTitle: (title) => setState(
                  () => this.title = title,
                ),
                onChangedDescription: (description) => setState(
                  () => this.description = description,
                ),
                onSavedTodo: editToto,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editToto() {
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
      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }
}
