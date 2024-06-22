import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class addWork extends StatefulWidget {
  final int s_id;
  const addWork(this.s_id, {Key? key}) : super(key: key);
  @override
  _addWorkState createState() => _addWorkState();
}

class _addWorkState extends State<addWork> {
  String _description = '';
  PlatformFile? _file;
  String workname = '';
  String? base64work;

  var socket;

  Future<void> connect(url, work) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      socket.add(work);
      socket.listen(
        (message) {
          print(message);
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

  void _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = result.files.last;
        workname = _file!.name;
      });
    }
    if (_file != null) {
      final filePath = _file!.path;
      try {
        final file = File(filePath!);
        final bytes = await file.readAsBytes();
        setState(() {
          base64work = base64Encode(bytes);
        });
      } catch (e) {
        print('Error reading file: $e');
      }
    }
  }

  void _saveFile() {
    print('desc: $_description');
    print('file: $workname');
    print('bytes : $base64work');
    var data = jsonEncode({
      's_id': widget.s_id,
      'w_name': workname,
      'w_data': base64work,
      'w_desc': _description
    });
    connect("ws://10.0.2.2:8768", data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' اضف عمل ال معرض الاعمال'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'ادخل وصف مناسب للملف',
              ),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectFile,
              child: Text('اختر ملف'),
            ),
            SizedBox(height: 16.0),
            if (_file != null)
              Text(
                '${_file?.name}',
                textAlign: TextAlign.right,
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveFile,
              child: Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
