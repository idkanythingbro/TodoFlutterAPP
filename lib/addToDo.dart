import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  void Function({required String todoText}) addTodo;
  AddToDo({super.key, required this.addTodo});
  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Add ToDo:"),
          TextField(
            onSubmitted: (value) {
              if (todoText.text.isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
              }
              todoText.text = "";
            },
            autofocus: true,
            controller: todoText,
            decoration:
                const InputDecoration(hintText: "Write your todo here...."),
          ),
          ElevatedButton(
              onPressed: () {
                if (todoText.text.isNotEmpty) {
                  widget.addTodo(todoText: todoText.text);
                }
                todoText.text = "";
              },
              child: const Text("Add"))
        ],
      ),
    );
  }
}
