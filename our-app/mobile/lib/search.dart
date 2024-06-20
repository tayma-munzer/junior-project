// ignore_for_file: unused_import
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  var socket;
  String _selectedCategory = 'services';
  final List<String> _categories = ['services', 'courses', 'jobs'];
  List<dynamic>? _searchResults;
  Map<String, dynamic>? results;
  List? indexes;

  Future<void> connect(url) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      //final data = {'search_string': _controller.text};
      final data = {'search_string': 'قواعد'};
      socket.add(jsonEncode(data));
      socket.listen(
        (message) {
          print("receive");
          setState(() {
            results = jsonDecode(message);
            _selectedCategory = 'services';
            _searchResults = results!['services'];
            Map<String, dynamic> data = _searchResults![0];
            indexes = data.keys.toList();
          });
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );
      print('WebSocket connection established.');
    } catch (e) {
      print('WebSocket connection failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'عن ماذا تريد البحث',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    connect("ws://10.0.2.2:8767");
                  },
                  child: Text('بحث '),
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                          _searchResults = results![_selectedCategory];
                          Map<String, dynamic> data = _searchResults![0];
                          indexes = data.keys.toList();
                          print(_searchResults);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            if (indexes != null && results != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_searchResults![index][indexes![1]]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
