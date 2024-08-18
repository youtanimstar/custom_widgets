import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class DropdownMenu_ extends StatefulWidget {
  final String labelName;
  final String? hint;
  final List? items;
  final String? api;
  final double? width;
  final String? firstItem;
  final ValueChanged<String?> onChanged;
  final String searchKey;

  DropdownMenu_(
      {super.key,
      required this.labelName,
      this.hint = "Select An Option",
      this.items = const [],
      this.api,
      this.width = 300,
      this.firstItem,
      required this.onChanged, required this.searchKey});

  @override
  State<DropdownMenu_> createState() => _DropdownMenu_State();
}

// ignore: camel_case_types
class _DropdownMenu_State extends State<DropdownMenu_> {
  String? _selectedItem;
  List<String> _dropdownItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.api != null) {
      fetchData();
    } else {
      _isLoading = false;
      _dropdownItems = List<String>.from(widget.items as Iterable);
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(widget.api!));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _dropdownItems = data.map((item) => item[widget.searchKey].toString()).toList();
          _dropdownItems.insert(0, widget.firstItem!);

          _isLoading = false; // Data fetched, stop loading
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading on error
      });
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  width: widget.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButton<String>(
                      hint: const Text("Select any value"),
                      value: _selectedItem,
                      isExpanded: true,
                      items: _dropdownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? selectedItem) {
                        widget.onChanged(selectedItem);
                        setState(() {
                          _selectedItem = selectedItem;
                        });
                      },
                      underline: Container(
                        height: 0, // Hide the underline
                        color: Colors.transparent, // Transparent color
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
