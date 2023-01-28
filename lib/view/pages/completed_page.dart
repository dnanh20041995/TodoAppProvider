import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controller/todo_provider.dart';
import 'package:todo_app_provider/view/widgets/todo_widget.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todosd = provider.todostodosCompleted;
    return todosd.isEmpty
        ? const Center(
            child: Text(
              "Nothing",
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
                  height: 8,
                ),
            itemBuilder: (context, index) {
              final todo = todosd[index];
              return TodoWidget(todo: todo);
            },
            itemCount: todosd.length);
  }
}
