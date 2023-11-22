import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/constant/color.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem({
    Key? key,
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        title: const Text(
          'good morning',
          style: TextStyle(
            color: tdBlack,
            fontSize: 16,
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text('Update'),
                onTap: () {
                  log('Update is pressed');
                },
              ),
              PopupMenuItem(
                child: const Text('Delete'),
                onTap: () {
                  setState(() {});
                  log('Delete is pressed');
                },
              ),
            ];
          },
        ),
      ),
    );
  }
}
