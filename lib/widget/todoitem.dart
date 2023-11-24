import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/constant/color.dart';

class ToDoItem extends StatefulWidget {
  final String title;
  final VoidCallback onDelete;
  const ToDoItem({
    Key? key,
    required this.title,
    required this.onDelete,
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
        title: Text(
          widget.title,
          style: const TextStyle(
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
                onTap: widget.onDelete,
                child: const Text('Delete'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
