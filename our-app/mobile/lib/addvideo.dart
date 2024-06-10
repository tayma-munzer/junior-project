import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/settings_.dart';
//simport 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class addvideo extends StatefulWidget {
  const addvideo({super.key});

  @override
  State<addvideo> createState() => _addvideoState();
}

class _addvideoState extends State<addvideo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Pusher Example'),
        ),
        body: MessageScreen(),
      ),
    );
  }
}

// class addvideo extends StatefulWidget {
//   const addvideo({super.key});

//   @override
//   State<addvideo> createState() => _addvideoState();
// }

// class _addvideoState extends State<addvideo> {

//   @override
//   void initState() {
//     super.initState();
//   }

// }

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  File? _videoFile;
  File? _video;
  String? video_name;
  String? base64video;
  final ImagePicker _picker = ImagePicker();
  String url = test_add_media;

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      video_name = pickedFile.name;
    }
    if (_videoFile != null) {
      final videoBytes = await _videoFile!.readAsBytes();
      setState(() {
        base64video = base64Encode(videoBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                print(video_name);
                print(base64video);
                var res = await http.post(Uri.parse(url), body: {
                  'c_id': '1',
                  'm_name': 'test_name',
                  'video_name': video_name,
                  'm_data': base64video,
                });
                print(res.body);
              },
              child: Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
