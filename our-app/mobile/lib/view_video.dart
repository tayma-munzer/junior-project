import 'package:flutter/material.dart';
//import 'package:pusher_channels_flutter/pusher-js/core/transports/url_schemes.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: view_video(),
    );
  }
}

class view_video extends StatefulWidget {
  @override
  _view_videoState createState() => _view_videoState();
}

class _view_videoState extends State<view_video> {
  late PusherChannelsFlutter pusher;
  List<int> videoData = [];
  //late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initPusher();
  }

  void _initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    pusher.init(apiKey: 'd65118057ff7e8473cf6', cluster: 'eu');
    var channel = pusher.subscribe(channelName: 'video-channel');
    // pusher.bind('App\\Events\\VideoChunkBroadcast', (event) {
    //   var chunk = base64Decode(event.data['chunk']);
    //   var chunkNumber = event.data['chunkNumber'];
    //   videoData.addAll(chunk);
    //   if (chunkNumber == 3) {
    //     // assuming 4 chunks for this example
    //     _playVideo();
    //   }
    // });
    //   channel.listen('App\\Events\\VideoChunkBroadcast', (event) {
    //   var chunk = base64Decode(event.data['chunk']);
    //   videoData.addAll(chunk);
    //   if (event.data['isLastChunk']) {
    //     _playVideo();
    //   }
    // });

    pusher.connect();
  }

  // void _playVideo() {
  //   _controller = VideoPlayerController.memory(Uint8List.fromList(videoData))
  //     ..initialize().then((_) {
  //       setState(() {});
  //       _controller.play();
  //     });
  // }

  @override
  void dispose() {
    //_controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: Center(
          // child: _controller != null && _controller.value.isInitialized
          //     ? AspectRatio(
          //         aspectRatio: _controller.value.aspectRatio,
          //         child: VideoPlayer(_controller),
          //       )
          //     : CircularProgressIndicator(),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendVideoRequest,
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  void _sendVideoRequest() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/requestvideo'),
      body: {'video_name': 'j2.mp4'},
    ).then((value) {
      if (value.statusCode == 200) {
        print('Video request sent');
      } else {
        print('Failed to send video request');
        print(value.statusCode);
      }
    });
  }
}
