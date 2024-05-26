import 'package:flutter/material.dart';

class VideoWidget extends StatefulWidget {
  final String videoId;
  final String videoName;
  final bool canEdit;
  final VoidCallback? onPressedDelete; // New callback function

  VideoWidget({
    required this.videoId,
    required this.videoName,
    required this.canEdit,
    this.onPressedDelete, // Assign the callback function to the parameter
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
        widget.onPressedDelete!(); // Call the callback function if provided
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
          color: Color.fromARGB(236, 250, 249, 249),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Icon(
                Icons.play_arrow_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 30),
            Text(
              widget.videoName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            if (widget.canEdit)
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.delete),
                color: deleteButtonColor,
                iconSize: 15,
              ),
          ],
        ),
      ),
    );
  }
}
