import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: const TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<dynamic> tasks = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/tasks'));
    setState(() {
      tasks = jsonDecode(response.body);
    });
  }

  Future<void> addTask() async {
    if (controller.text.isEmpty) return;
    await http.post(
      Uri.parse('http://localhost:8080/api/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': controller.text, 'done': false}),
    );
    controller.clear();
    loadTasks();
  }

  Future<void> toggleTask(dynamic task) async {
    await http.put(
      Uri.parse('http://localhost:8080/api/tasks/${task['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': task['title'],
        'done': !task['done'], // flip true<->false
      }),
    );
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse('http://localhost:8080/api/tasks/$id'));
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task['done'],
                    onChanged: (value) => toggleTask(task),
                  ),
                  title: Text(
                    task['title'],
                    style: TextStyle(
                      decoration: task['done']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteTask(task['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}