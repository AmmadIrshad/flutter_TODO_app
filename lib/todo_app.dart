import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List todoItems = [
    'Eat',
    'Drink',
    'sleep',
  ];

  TextEditingController addContorller = TextEditingController();
  TextEditingController updateContorller = TextEditingController();

  addTodo() {
    setState(
      () {
        if (addContorller.text.isNotEmpty) {
          todoItems.add(addContorller.text);
          addContorller.clear();
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //title: const Text("Empty Field"),
                title: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                ),
                content: const Text("Please enter a todo item."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  updateTodo(index) {
    updateContorller.text = todoItems[index];
    setState(() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextField(
              controller: updateContorller,
              style: const TextStyle(color: Colors.blue),
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    todoItems[index] = updateContorller.text;
                  });

                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  removeTodo(index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: TextField(
          //controller for getting entering text
          controller: addContorller,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: "Add Daily Tasks Here.....",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        actions: [
          Container(
            height: 54,
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                addTodo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Square shape
                ),
              ),
              child: const Text(
                "Add Todos",
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
            ),
            child: ListTile(
              tileColor: Colors.blue[300],
              title: Text(
                todoItems[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      updateTodo(index);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      removeTodo(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
