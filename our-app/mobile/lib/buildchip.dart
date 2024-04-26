import 'package:flutter/material.dart';
import 'dart:async';

class Buildchip extends StatefulWidget {
  final String topChip;
  final Widget page;
  final int index;

  Buildchip(
    this.topChip,
    this.page,
    this.index,
  );

  @override
  _BuildchipState createState() => _BuildchipState();
}

class _BuildchipState extends State<Buildchip> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isActive = true; // Update isActive to true when the chip is tapped
          });
          Timer(Duration(seconds: 30), () {
            setState(() {
              isActive = false; // Reset isActive after 20 seconds
            });
          });
          Navigator.pop(context); // Close the drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.page),
          );
        },
        child: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: BorderSide(
            color: isActive ? Color.fromARGB(255, 255, 224, 176) : Colors.black,
            width: 0.5,
          ),
          padding: EdgeInsets.all(8.0),
          label: Text(
            widget.topChip,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor:
              isActive ? Colors.white : Color.fromARGB(255, 255, 224, 176),
        ),
      ),
    );
  }
}
