import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:open_file/open_file.dart';

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
    // TODO: implement initState
    super.initState();
    connect("ws://10.0.2.2:8769");
  }

  @override
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
      appBar: AppBar(
        title: Text('File Viewer'),
      ),
      body: ListView.builder(
        itemCount: works!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(works![index]['w_name']),
            onTap: () async {
              final tempDir = await getTemporaryDirectory();
              final w_name = works![index]['w_name'];
              final filePath = '${tempDir.path}/${w_name}';
              final List<int> fileBytes =
                  works![index]['w_bytes'].whereType<int>().toList();
              await File(filePath).writeAsBytes(fileBytes);
              //await OpenFile.open(filePath);
            },
          );
        },
      ),
    );
  }

  // Future<void> _openFile(FileItem file) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final filePath = '${tempDir.path}/${file.name}';
  //   await File(filePath).writeAsBytes(base64Decode(file.bytes));
  //   await OpenFile.open(filePath);
  // }
}
