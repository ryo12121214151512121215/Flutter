import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      home: MyHomePage(), // ← ここで使っているクラスを定義する必要あり
    );
  }
}

// ✅ ここが必要！
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODOアプリ')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'タスクを入力'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.text.isNotEmpty) {
                        _tasks.add({'title': _controller.text, 'done': false});
                        _controller.clear();
                      }
                    });
                  },
                  child: Text("追加"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder:
                  (context, index) => CheckboxListTile(
                    title: Text(
                      _tasks[index]['title'],
                      style: TextStyle(
                        decoration:
                            _tasks[index]['done']
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    value: _tasks[index]['done'],
                    onChanged: (value) {
                      setState(() {
                        _tasks[index]['done'] = value;
                      });
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
