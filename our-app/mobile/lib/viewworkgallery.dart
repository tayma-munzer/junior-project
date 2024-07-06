import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart'; // Import the open_file package

class viewworkgallery extends StatefulWidget {
  final int s_id;
  const viewworkgallery(this.s_id, {Key? key}) : super(key: key);

  @override
  State<viewworkgallery> createState() => _viewworkgalleryState();
}

class _viewworkgalleryState extends State<viewworkgallery> {
  Map<String, dynamic>? worksmap;
  List<dynamic>? works;

  @override
  void initState() {
    super.initState();
    connect("ws://10.0.2.2:8769"); // Assuming your WebSocket URL is correct
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
      body: ListView.builder(
        itemCount: works != null ? works!.length : 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(works![index]['w_name']),
            onTap: () async {
              final tempDir = await getTemporaryDirectory();
              final w_name = works![index]['w_name'];
              final filePath = '${tempDir.path}/$w_name';
              final List<int> fileBytes =
                  works![index]['w_bytes'].whereType<int>().toList();
              await File(filePath).writeAsBytes(fileBytes);

              try {
                final result = await OpenFile.open(filePath);
                if (result.type == ResultType.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to open file: ${result.message}'),
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
          );
        },
      ),
    );
  }
}
