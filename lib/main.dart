import 'package:custom_widgets_2/widgets/dropdown_menu.dart';
import 'package:custom_widgets_2/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? select;

  void updateSelect(String? newValue) {
    setState(() {
      select = newValue;
      print(select);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Custom Widget",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          RoundedButton(
            btnName: "Lock",
            textStyle: const TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w800),
            callback: () {
              print(select);
            },
          ),
          const SizedBox(
            height: 50,
          ),
          DropdownMenu_(
            labelName: "Select Title",
            onChanged: updateSelect,
            // items: ["hello", "hi"],
            api: "https://jsonplaceholder.typicode.com/posts",
            searchKey: "title",
            firstItem: "All",
            width: 300,
          )
        ],
      ),
    );
  }
}
