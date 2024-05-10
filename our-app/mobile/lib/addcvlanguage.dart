import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/viewCV.dart';

class addCVLanguages extends StatefulWidget {
  final int cv_id;
  const addCVLanguages(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<addCVLanguages> createState() => _addCVLanguagesState();
}

class _addCVLanguagesState extends State<addCVLanguages> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> lang_type = [];
  String selectedMainCategory = 'a';
  List selected = [];
  List selected_id = [];
  String select_id = '';

  void fetch() async {
    print('object');
    var url = get_all_languages;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      lang_type = data.map((item) => item).toList();
      selectedMainCategory = lang_type[0]['language'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown list
          DropdownButton<String>(
            value: selectedMainCategory,
            hint: Text('Select an item'),
            onChanged: (newValue) {
              setState(() {
                selectedMainCategory = newValue!;
              });
            },
            items: lang_type.map((item) {
              return DropdownMenuItem<String>(
                value: item['language'],
                child: Text(item['language']),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              if (!selected.contains(selectedMainCategory)) {
                setState(() {
                  selected.add(selectedMainCategory);
                  print('language added to the list');
                });
              } else
                print('language does exist');
            },
            child: Container(
              width: screenWidth - 50,
              child: Center(
                child: Text(
                  'اضف ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => viewcv(),
                        ));
                  },
                  child: Text(' تخطي'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    for (var s in selected) {
                      for (var item in lang_type)
                        if (s == item['language']) {
                          Map<String, dynamic> id = {
                            'l_id': item['l_id'].toString(),
                          };
                          selected_id.add(id);
                        }
                    }
                    print('object');
                    print(selected_id);
                    AuthCont.add_languages(widget.cv_id.toString(), selected_id)
                        .then((value) {
                      if (value.statusCode == 200) {
                        print(
                            ' language added to the CV sucessfully successfully');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => viewcv()),
                        );
                      } else {
                        // Error response
                        print(
                            'Failed to add the languages to the CV. Error: ${value.body}');
                      }
                    });
                  },
                  child: Text(' التالي'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // List view
          Expanded(
            child: ListView.builder(
              itemCount: selected.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selected[index]),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
