import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todo_app/constant/color.dart';
import 'package:todo_app/widget/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All To Dos',
                          style: TextStyle(
                            color: tdBlack,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ...List.generate(
                        5,
                        (index) => const ToDoItem(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    onPressed: addedTitle,
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBgColor,
      centerTitle: true,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu_rounded,
            color: tdBlack,
            size: 30,
          ),
          Icon(
            Icons.account_circle,
            color: tdBlack,
            size: 30,
          ),
        ],
      ),
    );
  }

  Future<void> addedTitle() async {
    final title = searchController.text;

    final body = {
      'title': title,
      'is_completed': false,
    };

    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      showSuccessMessage('Title Added Successfully');
      showSuccessMessage(response.body);
    } else {
      showErrorMessage(response.body);
    }
    setState(() {
      searchController.clear();
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Widget searchBox() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: tdGrey,
          ),
          prefixIconColor: tdGrey,
        ),
      ),
    );
