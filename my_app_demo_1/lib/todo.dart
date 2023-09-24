import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(title: 'Todo Manager'),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});

  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String name, String description) {
    setState(() {
      _todos.add(Todo(name: name, description: description, completed: false));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.name == todo.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
              todo: todo,
              onTodoChanged: _handleTodoChange,
              removeTodo: _deleteTodo);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayDialog() async {
    String todoName = '';
    String todoDescription = '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: 'Todo Name'),
                autofocus: true,
                onChanged: (value) {
                  todoName = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(hintText: 'Todo Description'),
                onChanged: (value) {
                  todoDescription = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(todoName, todoDescription);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Todo {
  Todo(
      {required this.name, required this.description, required this.completed});
  String name;
  String description;
  bool completed;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.removeTodo,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: todo.completed,
        onChanged: (value) {
          onTodoChanged(todo);
        },
      ),
      title: GestureDetector(
        onTap: () {
          // Navigate to the DetailScreen when the Todo Name is tapped
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(todo: todo),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(todo.name, style: _getTextStyle(todo.completed)),
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              alignment: Alignment.centerRight,
              onPressed: () {
                removeTodo(todo);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
