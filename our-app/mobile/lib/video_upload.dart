import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mobile/settings_.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class video_upload extends StatefulWidget {
  const video_upload({super.key});

  @override
  State<video_upload> createState() => _video_uploadState();
}

class _video_uploadState extends State<video_upload> {
  // late PusherChannelsFlutter pusher;
  // String _message = 'Waiting for messages...';

  // @override
  // void initState() {
  //   super.initState();
  //   initPusher();
  // }

  // @override
  // void dispose() {
  //   pusher.disconnect();
  //   pusher.unsubscribe(channelName: "my-chan");
  //   super.dispose();
  // }

  // void initPusher() async {
  //   pusher = PusherChannelsFlutter.getInstance();
  //   try {
  //     print('object');
  //     // await pusher.init(
  //     //   apiKey: "d65118057ff7e8473cf6",
  //     //   cluster: "eu",
  //     //   onConnectionStateChange: onConnectionStateChange,
  //     //   onError: onError,
  //     //   onSubscriptionSucceeded: onSubscriptionSucceeded,
  //     //   onEvent: onEvent,
  //     // );
  //     print('hiii');
  //     await pusher.subscribe(
  //       channelName: 'my-chan',
  //     );
  //     print('llllllllllll');
  //     await pusher.connect();
  //   } catch (e) {
  //     print("error in initialization: $e");
  //   }
  // }

  // void onConnectionStateChange(dynamic currentState, dynamic previousState) {
  //   print("Connection state changed: $currentState");
  // }

  // void onError(String message, int? code, dynamic e) {
  //   print("Error: $message, Code: $code, Exception: $e");
  // }

  // void onSubscriptionSucceeded(String channelName, dynamic data) {
  //   print("Subscription succeeded: $channelName, Data: $data");
  // }

  // void onEvent(PusherEvent event) {
  //   setState(() {
  //     _message = event.data;
  //   });
  //   print("Event: ${event.eventName}, Data: ${event.data}");
  // }

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

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  File? _video;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initPusher();
  }

  Future<void> initPusher() async {
    await pusher.init(
      apiKey: "d65118057ff7e8473cf6",
      cluster: "eu",
      onEvent: onPusherEvent,
    );

    await pusher.subscribe(channelName: "video-upload");
  }

  void onPusherEvent(PusherEvent event) {
    print("Event received: ${event.data}");
    // Handle the incoming video chunk
  }
  // Future<void> sendMessage(String message) async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:8000/api/send-message'),
  //     body: jsonEncode(<String, String>{
  //       'message': message,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     throw Exception('Failed to send message');
  //   }
  // }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
      _uploadVideoChunks(_video!);
    }
  }

  Future<void> _uploadVideoChunks(File videoFile) async {
    final fileSize = videoFile.lengthSync();
    final chunkSize = 100 * 100; // 1 MB
    final totalChunks = (fileSize / chunkSize).ceil();

    for (int i = 0; i < totalChunks; i++) {
      final start = i * chunkSize;
      final end = start + chunkSize;
      final chunk = videoFile
          .readAsBytesSync()
          .sublist(start, end > fileSize ? fileSize : end);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/upload-chunk'),
      );
      request.files.add(
          http.MultipartFile.fromBytes('chunk', chunk, filename: 'chunk-$i'));

      request.fields['filename'] = videoFile.path.split('/').last;
      request.fields['chunkNumber'] = i.toString();

      var response = await request.send().then((value) {
        if (value.statusCode == 200) {
          print('Chunk $i uploaded!');
          print(value.statusCode);
          print(value.reasonPhrase);
        } else {
          print('Chunk $i upload failed!');
          print(value.statusCode);
          print(value.reasonPhrase);
        }
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
          children: <Widget>[
            if (_video != null) ...[
              Text('Video Selected: ${_video!.path}'),
            ],
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on http.MultipartFile {
  Future<List<int>> toBytes() async {
    final completer = Completer<List<int>>();
    final byteSink = ByteConversionSink.withCallback((bytes) {
      completer.complete(bytes);
    });
    finalize().listen(byteSink.add, onDone: byteSink.close);
    return completer.future;
  }
}
