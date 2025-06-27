import 'package:flutter/material.dart';

class TodoListStaticPage extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = List.generate(
    10,
    (index) => {"title": "Task ${index + 1}", "done": false},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(task["title"]),
              subtitle: Text("Pending"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.grey),
                  SizedBox(width: 8),
                  Icon(Icons.delete, color: Colors.red),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
