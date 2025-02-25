import 'package:flutter/material.dart';

void main() {
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TaskListScreen());
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  bool? _isChecked = false;

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({'text': taskController.text, 'isChecked': false});
        taskController.clear();
      });
    }
  }

  void toggleTask(int index, bool? newValue) {
    setState(() {
      tasks[index]['isChecked'] = newValue ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TaskList')),
      body: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Tasks",
              suffixIcon: ElevatedButton(
                onPressed: addTask,
                child: Text('Add'),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(tasks[index]['text']),
                  value: tasks[index]['isChecked'],
                  onChanged: (newValue) => toggleTask(index, newValue),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
