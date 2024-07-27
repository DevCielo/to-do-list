import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

List<Todo> _todos = [
  Todo('Task One', 'take out trash'),
  Todo('Task two', 'paint the house')
];

void main() {
  runApp(MaterialApp(title: 'To do list', home: TodosScreen(todos: _todos)));
}

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  _TodosScreenState createState() {
    return _TodosScreenState();
  }
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Tasks')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todos[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DetailScreen(todo: _todos[index]);
                }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo? newTodo = await showDialog<Todo>(
            context: context,
            builder: (BuildContext context) {
              String? title;
              String? description;

              return AlertDialog(
                title: Text('Create New Task'),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: 'Title'),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Description'),
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (title != null && description != null) {
                        Navigator.pop(context, Todo(title!, description!));
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
          if (newTodo != null) {
            setState(() {
              _todos.add(newTodo);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.todo}) : super(key : key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(todo.title)),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(todo.description),
    )
    );
  }
}





/* 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'App', home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String _selection = 'None';

  _startSelectionScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SecondScreen();
      }),
    );

    setState(() {
      _selection = result ?? 'None';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selection Was: $_selection'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startSelectionScreen,
              child: const Text('Select an Option'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Option 1'),
              onPressed: () {
                Navigator.pop(context, 'Option One');
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Option Two');
              },
              child: const Text('Option 2'),
            ),
          ],
        ),
      ),
    );
  }
}
 */