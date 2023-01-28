import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controller/todo_provider.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/view/widgets/todo_form_widget.dart';
import 'package:todo_app_provider/view/widgets/update_form_widget.dart';
import 'package:todo_app_provider/view/widgets/utlis.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        key: Key(widget.todo.id),
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (_) {
              /* Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UpdateTodo(todo: todo);
              })); */

              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                                title: widget.todo.title,
                                description: widget.todo.description,
                                onChangedTitle: (title) => setState(
                                  () => widget.todo.title = title,
                                ),
                                onChangedDescription: (description) => setState(
                                  () => widget.todo.description = description,
                                ),
                                onSavedTodo: () {
                                  final isValid =
                                      _formKey.currentState!.validate();
                                  if (!isValid) {
                                    return;
                                  } else {
                                    final todo = Todo(
                                        createdTime: DateTime.now(),
                                        id: DateTime.now().toString(),
                                        title: widget.todo.title,
                                        description: widget.todo.description);

                                    final provider = Provider.of<TodosProvider>(
                                        context,
                                        listen: false);
                                    provider.updateTodo(
                                        widget.todo,
                                        widget.todo.title,
                                        widget.todo.description);

                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'edit',
          ),
        ]),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (_) {
              deleteTodo(context, widget.todo);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete',
          ),
        ]),
        child: buildTodo(context),
      ),
    );
  }

  @override
  Widget buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: widget.todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(widget.todo);
                Utils.showSnackBar(
                    context, isDone ? "Đã hoàn thành" : "Chưa hoàn thành");
              }),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              if (widget.todo.description.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.todo.description,
                    style: const TextStyle(fontSize: 20, height: 1.5),
                  ),
                ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.todo.isDone == false
                        ? widget.todo.createdTime.toString()
                        : widget.todo.doneTime,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);
    Utils.showSnackBar(context, "Đã xóa ghi chú");
  }
}
