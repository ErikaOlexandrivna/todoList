import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoListScreen());
  }
}

class TodoListScreen extends StatefulWidget{`
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todoList = [];
  List<String> completedList = [];
  TextEditingController textController = TextEditingController();

  void addTodoItem(String task) {
    setState(() {
      todoList.add(task);
      textController.clear();
    });
  }

  void toggleCompletion(String task) {
    setState(() {
      if (completedList.contains(task)) {
        completedList.remove(task);
      } else {
        completedList.add(task);
      }
    });
  }

  Widget _buildTodoItem(String task) {
    bool completed = completedList.contains(task);
    return ListTile(
      leading: const Icon(Icons.start),
      title: Text(task,
          style: TextStyle(
            decoration: completed ? TextDecoration.lineThrough : null,
          )),
      trailing: Checkbox(
        onChanged: (value) {
          toggleCompletion(task);
        },
        value: completed,
      ),
      onTap: () => toggleCompletion(task),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO list'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < todoList.length) {
            return _buildTodoItem(todoList[index]);
          } else {
            null;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<AlertDialog?> displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Додай завдання до списку'),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Веди нове завдання',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  addTodoItem(textController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Додати'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Закрити'),
              ),
            ],
          );
        });
  }
}
