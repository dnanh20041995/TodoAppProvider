import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget(
      {super.key,
      this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSavedTodo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          buildDes(),
          const SizedBox(
            height: 20,
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        initialValue: title,
        maxLines: 1,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'Vui lòng nhập nội dung tiêu đề!!!';
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), labelText: "Tiêu đề"),
      );

  Widget buildDes() => TextFormField(
        initialValue: description,
        maxLines: 3,
        onChanged: onChangedDescription,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), labelText: "Nội dung"),
      );

  Widget buildButton() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onSavedTodo, child: const Text("Lưu")));
}
