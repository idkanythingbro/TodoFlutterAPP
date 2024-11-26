import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/addToDo.dart';
import 'package:todoapp/widgets/todoList.dart';
import 'package:url_launcher/url_launcher.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todoItems = [];

  void showAddTodoBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 250,
              child: AddToDo(
                addTodo: addTodo,
              ),
            ),
          );
        });
  }

  void addTodo({required String todoText}) {
    if (todoItems.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Already Exists"),
              content: const Text("This item already exists !!"),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          });
      return;
    }
    setState(() {
      todoItems.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', todoItems);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoItems = (prefs.getStringList("items") ?? []).toList();
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: showAddTodoBottomSheet,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey[700],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blue[900],
              height: 100,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Todo App',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://www.youtube.com/"));
              },
              leading: const Icon(Icons.person),
              title: const Text(
                'User Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("mailto:sonupra1802@gmail.com"));
              },
              leading: const Icon(Icons.email),
              title: const Text(
                'Contact Me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App"),
      ),
      body: TodoList(todoItems: todoItems, updateLocalData: updateLocalData),
    );
  }
}
