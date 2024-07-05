import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

import 'appbar.dart';
import 'bottombar.dart';
import 'drawer.dart';

class view_media_new extends StatefulWidget {
  final String videoId;
  final String videoName;

  view_media_new({required this.videoId, required this.videoName});

  @override
  _view_media_newState createState() => _view_media_newState();
}

class _view_media_newState extends State<view_media_new> {
  VideoPlayerController? _videoPlayerController;
  File? _tempVideoFile;
  File? _video;
  var socket;
  String video_name = "";
  String video_desc = "";
  final ImagePicker _picker = ImagePicker();
  double _sliderValue = 0.0;
  bool _isSliderChanging = false;
  bool _isPlaying = false;

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
    connect("ws://10.0.2.2:8765", widget.videoId);
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
        _videoPlayerController?.addListener(() {
          if (_videoPlayerController!.value.isInitialized &&
              !_isSliderChanging) {
            setState(() {
              _sliderValue = _videoPlayerController!.value.position.inMilliseconds /
                  _videoPlayerController!.value.duration.inMilliseconds;
            });
          }
        });
      });

    print('Video saved: $videoName');
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }
  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
        _isPlaying = false;
      } else {
        if (_videoPlayerController!.value.position >=
            _videoPlayerController!.value.duration) {
          _videoPlayerController!.seekTo(Duration.zero);
        }
        _videoPlayerController!.play();
        _isPlaying = true;
      }
    });
  }

  void _onSliderChanged(double value) {
    if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized) {
      final double newPosition = value * _videoPlayerController!.value.duration.inMilliseconds;
      _videoPlayerController!.seekTo(Duration(milliseconds: newPosition.toInt()));
    }
  }

  void _onSliderChangeStart(double value) {
    setState(() {
      _isSliderChanging = true;
    });
  }

  void _onSliderChangeEnd(double value) {
    setState(() {
      _isSliderChanging = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Card(
              elevation: 4, // Increased card elevation
              color: Colors.blue.shade400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  video_name,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 220,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                    aspectRatio:
                    _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController!),
                  )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
            Card(
              color:Colors.grey.shade50,
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: _isSliderChanging
                        ? _sliderValue
                        : (_videoPlayerController != null &&
                        _videoPlayerController!.value.isInitialized &&
                        !_isSliderChanging
                        ? _sliderValue
                        : 0.0),
                    min: 0.0,
                    max: 1.0,
                    onChanged: _onSliderChanged,
                    onChangeStart: _onSliderChangeStart,
                    onChangeEnd: _onSliderChangeEnd,
                    activeColor: Colors.blue.shade400,
                    inactiveColor: Colors.grey.shade300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 32,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Card(
              color:Colors.grey.shade50,
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    video_desc,
                    style: TextStyle(fontSize: 20),
                  ),
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
