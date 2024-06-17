import 'package:flutter/material.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  final String videoName;
  final bool canEdit;
  final VoidCallback? onPressedDelete;

  VideoWidget({
    required this.videoId,
    required this.videoName,
    required this.canEdit,
    this.onPressedDelete,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  Color deleteButtonColor = Colors.grey;

  void onPressed() {
    setState(() {
      deleteButtonColor = Colors.red;
      if (widget.onPressedDelete != null) {
        widget.onPressedDelete!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                widget.videoName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (widget.canEdit)
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.delete),
                color: deleteButtonColor,
                iconSize: 30,
              ),
          ],
        ),
      ),
    );
  }
}
