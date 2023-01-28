import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controller/todo_provider.dart';
import 'package:todo_app_provider/view/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFFf6f5ee),
        ),
        home: const HomePage(),
      ),
    );
  }
}
