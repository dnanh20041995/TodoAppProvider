class Todo {
  DateTime createdTime;
  String doneTime;
  String id;
  String title;
  String description;
  bool isDone;
  Todo({
    required this.createdTime,
    this.doneTime = '',
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
  });
}
