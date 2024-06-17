import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoId;
  final String videoName;

  VideoPlayerPage({
    required this.videoId,
    required this.videoName,
  });
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller = VideoPlayerController.asset('');
  bool _isVideoLoaded = false;
  bool _isDragging = false;
  double _currentSliderValue = 0.0;


  @override
  void initState() {
    super.initState();
    _fetchVideoUrl();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchVideoUrl() async {
    // Make an API call to fetch the video URL based on widget.videoId
    var apiUrl = 'your_api_url_here/${widget.videoId}';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var videoUrl = json.decode(response.body)['m_path'];

      setState(() {
        _controller = VideoPlayerController.asset(videoUrl);
        _controller.initialize().then((_) {
          setState(() {
            _isVideoLoaded = true;
          });
        });
        _controller.addListener(_onVideoProgress);
      });
    } else {
      print('Failed to fetch video URL. Status code: ${response.statusCode}');
    }
  }

  void _onVideoProgress() {
    if (_controller.value.isInitialized && !_isDragging) {
      setState(() {
        _currentSliderValue = _controller.value.position.inSeconds.toDouble();
      });
    }
  }

  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_controller.value.isInitialized && !_isDragging) {
      double currentPosition = _controller.value.position.inSeconds.toDouble();
      double delta = details.primaryDelta ?? 0.0;
      double totalDuration = _controller.value.duration.inSeconds.toDouble();
      double newPosition =
          currentPosition + delta * totalDuration / context.size!.width;
      _controller.seekTo(Duration(seconds: newPosition.toInt()));
      setState(() {
        _currentSliderValue = newPosition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Scaffold(
        // Show a loading indicator or any other desired widget
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _isVideoLoaded
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    onHorizontalDragStart: _onDragStart,
                    onHorizontalDragEnd: _onDragEnd,
                    onHorizontalDragUpdate: _onDragUpdate,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            _isVideoLoaded
                ? Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Slider(
                      value: _currentSliderValue,
                      min: 0.0,
                      max: _controller.value.duration.inSeconds.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                        _controller.seekTo(Duration(seconds: value.toInt()));
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              backgroundColor: AppColors.appColor,
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // Navigate to the previous page
              },
              backgroundColor: AppColors.appColor,
              child: const Icon(
                Icons.cancel_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
