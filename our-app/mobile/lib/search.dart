import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/CategoriesDetails.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/readcourse.dart';
import 'package:mobile/viewcoursetobuy.dart';
import 'package:mobile/viewjob.dart';
import 'package:mobile/viewservice.dart';
import 'package:mobile/viewservicetobuy.dart';
import 'package:mobile/wallet.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  late WebSocket socket;
  String _selectedCategory = 'services';
  final List<String> _categories = ['services', 'courses', 'jobs'];
  List<dynamic>? _searchResults;
  Map<String, dynamic>? results;
  List<String>? indexes;

  Future<void> connect(url) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'عن ماذا تريد ان تبحث',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    connect("ws://10.0.2.2:8767");
                  },
                  child: Text(
                    'بحث',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 243, 176, 145)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    cursorColor: Colors.black,
                  ),
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
                          indexes = _searchResults![0].keys.toList();
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
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    itemCount: _searchResults!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  if (_selectedCategory == 'services') {
                                    return CategoriesDetails(
                                        _searchResults![index][indexes![0]]);
                                  } else if (_selectedCategory == 'courses') {
                                    return CourseDetailsPage(
                                        _searchResults![index][indexes![0]]);
                                  } else {
                                    return viewjob(
                                        _searchResults![index][indexes![0]]);
                                  }
                                },
                              ),
                            );
                          },
                          child: Text(_searchResults![index][indexes![1]]),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
