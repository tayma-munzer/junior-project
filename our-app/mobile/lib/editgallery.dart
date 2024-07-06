import 'package:flutter/material.dart';
import 'package:mobile/addwork.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

class Editgallery extends StatefulWidget {
  final int s_id;

  const Editgallery(this.s_id, {Key? key}) : super(key: key);

  @override
  State<Editgallery> createState() => _EditgalleryState();
}

class _EditgalleryState extends State<Editgallery> {
  Map<String, dynamic>? worksmap;
  List<dynamic>? works;

  @override
  void initState() {
    super.initState();
    connect("ws://10.0.2.2:8769");
  }

  var socket;
  Future<void> connect(url) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      final data = {'s_id': widget.s_id};
      socket.add(jsonEncode(data));
      socket.listen(
        (message) {
          print("receive");
          setState(() {
            worksmap = json.decode(message);
            works = worksmap!['works'];
            print(works!.length);
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/homepage.png',
              width: 350,
              height: 300,
            ),
            works != null && works!.isEmpty
                ? Text(
                    'لا يوجد اعمال لعرضها  \n اضغط على الايقونة لاضافة اعمالك',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: works != null ? works!.length : 0,
                      itemBuilder: (context, index) {
                        Color color = index % 2 == 0
                            ? const Color.fromARGB(255, 143, 205, 255)
                            : Colors.white;
                        return Container(
                          color: color,
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                var url = delete_work;
                                var res = await http.post(Uri.parse(url),
                                    body: {
                                      'w_id': works![index]['w_id'].toString()
                                    });
                                if (res.statusCode == 200) {
                                  print('deleted successfully');
                                  Map data = json.decode(res.body);
                                  setState(() {
                                    works = data['works'];
                                  });
                                } else {
                                  print('something went wrong');
                                }
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(works![index]['w_desc']),
                                      Text(works![index]['w_name']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              final tempDir = await getTemporaryDirectory();
                              final w_name = works![index]['w_name'];
                              final filePath = '${tempDir.path}/$w_name';
                              final List<int> fileBytes = works![index]
                                      ['w_bytes']
                                  .whereType<int>()
                                  .toList();
                              await File(filePath).writeAsBytes(fileBytes);

                              try {
                                final result = await OpenFile.open(filePath);
                                if (result.type == ResultType.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to open file: ${result.message}'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to open file: $e'),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addWork(widget.s_id)),
                );
              },
              child: Icon(
                Icons.add_circle,
                size: 60,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
