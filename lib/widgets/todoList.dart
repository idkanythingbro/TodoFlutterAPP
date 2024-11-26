import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  List<String> todoItems;
  void Function() updateLocalData;
  TodoList({super.key, required this.todoItems, required this.updateLocalData});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  void onItemClick({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.todoItems.removeAt(index);
                  });
                  widget.updateLocalData();
                  Navigator.pop(context);
                },
                child: const Text("Mark as done.")),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoItems.isEmpty)
        ? const Center(child: Text("No Items in the List"))
        : ListView.builder(
            itemCount: widget.todoItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                key: UniqueKey(),
                background: Container(
                  color: Colors.green[300],
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoItems.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemClick(index: index);
                  },
                  title: Text(widget.todoItems[index]),
                ),
              );
            });
  }
}
