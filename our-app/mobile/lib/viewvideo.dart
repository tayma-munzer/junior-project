import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editjob.dart';
import 'package:mobile/firstpage.dart';
import 'package:mobile/main.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class viewvideo extends StatefulWidget {
  final int m_id;
  const viewvideo(this.m_id, {Key? key}) : super(key: key);

  @override
  State<viewvideo> createState() => _viewvideoState();
}

Map<String, dynamic>? mediadetails;
String? video;
VideoPlayerController? _controller;
MemoryImage? videoMemoryImage;

class _viewvideoState extends State<viewvideo> {
  void fetchservice() async {
    print('object');
    var url = test_get_media;
    var res =
        await http.post(Uri.parse(url), body: {"m_id": widget.m_id.toString()});
    //print(res.body);
    setState(() {
      mediadetails = json.decode(res.body);
      video = mediadetails!['video'];
      // print(mediadetails);
      // print('object');
      // print(video);
    });
    List<int> videoBytes = base64Decode(mediadetails!['video']);
    print('object');
    print(videoBytes);
    final directory = await getTemporaryDirectory();
    print('object');
    print(directory.path);
    final videoFile = File('${directory.path}/video.mp4');
    // File videoFile = File('.mp4');
    await videoFile.writeAsBytes(videoBytes);
    print('done writing');
    _controller = VideoPlayerController.file(videoFile);
    print('1');
    await _controller!.initialize();
    print('done init');
    // Uint8List data = Uint8List.fromList(videoBytes);
    // videoMemoryImage = MemoryImage(data);
  }

  @override
  void initState() {
    super.initState();
    fetchservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            //VideoPlayer(_controller!)
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
