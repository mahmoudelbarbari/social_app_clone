import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/models/task.dart';
import 'package:flutter_application_1/day3/widgets/common_elevated_button_widget.dart';
import 'package:flutter_application_1/day3/widgets/login_textfield_widget.dart';

class AddPostWidget extends StatefulWidget {
  final void Function(Task) onAddTask;
  const AddPostWidget({super.key, required this.onAddTask});

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late final GlobalKey<FormState> keyform;

  final List<Task> tasks = [];

  @override
  void initState() {
    keyform = GlobalKey<FormState>();
    super.initState();
  }

  void _addTask() {
    if (keyform.currentState!.validate()) {
      final taskText = _taskController.text.trim();
      final descText = _descController.text.trim();
      if (taskText.isNotEmpty && !taskText.contains(' ')) {
        final newTask = Task(0, taskText, descText);
        Task.addTask(newTask);
        _taskController.clear();
        _descController.clear();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text("Add new task")),
      content: SafeArea(
        child: Form(
          key: keyform,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginTextFieldWidget(
                controller: _taskController,
                labelText: "Title",
                formFieldValidator: (value) {
                  if (value == null || value.length < 5) {
                    return "Please fill this field";
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.task_alt_sharp),
              ),
              SizedBox(height: 12),
              LoginTextFieldWidget(
                controller: _descController,
                labelText: "Description",
                formFieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.description),
              ),
            ],
          ),
        ),
      ),

      actions: [CommonElevatedButton(onTap: _addTask, text: "Add Task")],
    );
  }
}
