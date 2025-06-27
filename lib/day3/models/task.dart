class Task {
  int id;
  String? title;
  String? description;
  bool? isArchived;
  Task(this.id, this.title, this.description, {this.isArchived});

  static final List<Task> _tasks = [];

  static List<Task> getTasks() => _tasks;
  static void addTask(Task task) => _tasks.add(task);
  static void removeTask(int index) => _tasks.removeAt(index);
}
