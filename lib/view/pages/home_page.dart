import 'package:flutter/material.dart';
import 'package:todo_app_provider/view/pages/completed_page.dart';
import 'package:todo_app_provider/view/pages/todo_list_page.dart';
import 'package:todo_app_provider/view/widgets/add_todo_dialog_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoList(),
      CompletedPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ghi chú"),
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return const AddTodoDialogWidget();
              })),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          unselectedItemColor: const Color.fromARGB(255, 175, 175, 175),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) {
            return setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.fact_check_outlined), label: "Danh sách"),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: "Hoàn tất")
          ]),
    );
  }
}
