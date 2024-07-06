import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';

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

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

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
    if (_description.isEmpty) {
      _showSnackbar('يُرجى ملء حقل الوصف');
      return;
    }
    if (_file == null) {
      _showSnackbar('يُرجى اختيار ملف');
      return;
    }

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/works.png',
                width: 20,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'وصف الملف',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ادخل وصف مناسب للملف',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _selectFile,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(300, 40)),
                ),
                child: Text(
                  ' اختر ملفا',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              if (_file != null)
                Text(
                  '${_file?.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveFile,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(300, 40)),
                ),
                child: Text(
                  ' حفظ التغيريات',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
