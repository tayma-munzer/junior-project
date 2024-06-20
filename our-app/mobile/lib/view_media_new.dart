import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(view_media_new());
}

class view_media_new extends StatefulWidget {
  @override
  _view_media_newState createState() => _view_media_newState();
}

class _view_media_newState extends State<view_media_new> {
  //late WebSocketClient _webSocketClient;
  VideoPlayerController? _videoPlayerController;
  File? _tempVideoFile;
  File? _video;
  var socket;
  String video_name = "waiting for video";
  String video_desc = "";
  final ImagePicker _picker = ImagePicker();
  // Future<void> _pickVideo() async {
  //   final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _webSocketClient.sendMessage(pickedFile.path);
  //       //_video = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> connect(url, m_id) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      final data = {'m_id': m_id};
      socket.add(jsonEncode(data));
      socket.listen(
        (message) {
          print("receive");
          _handleWebSocketvideo(message);
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
  void initState() {
    super.initState();
    // number 1 is the id of the media you want to get
    connect("ws://10.0.2.2:8765", "1");
  }

  void _handleWebSocketvideo(dynamic message) async {
    final data = json.decode(message);
    final videoName = data['m_name'];
    setState(() {
      video_name = data['m_title'];
      video_desc = data['m_desc'];
    });
    final bytes = data['bytes'];
    final List<int> videoBytes = bytes.whereType<int>().toList();
    final tempDir = await getTemporaryDirectory();
    _tempVideoFile = File('${tempDir.path}/$videoName');
    print(55);
    await _tempVideoFile?.writeAsBytes(videoBytes);
    _videoPlayerController = VideoPlayerController.file(_tempVideoFile!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController?.play();
      });

    print('Video saved: $videoName');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(video_name),
        ),
        body: Center(
          child: _videoPlayerController != null &&
                  _videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                )
              : CircularProgressIndicator(),
        ),
        bottomSheet: Text(video_desc),
      ),
    );
  }
}
