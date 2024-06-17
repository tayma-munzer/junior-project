import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:string_2_icon/string_2_icon.dart';

class CircleItem extends StatelessWidget {
  final dynamic data;
  final Function onTap;
  final String iconKey;
  final String title;

  const CircleItem({
    required this.data,
    required this.onTap,
    required this.iconKey,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          splashColor: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350]!.withOpacity(0.8),
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Icon(
                    String2Icon.getIconDataFromString(data[iconKey]),
                    color: Colors.blue[400],
                    size: MediaQuery.of(context).size.width / 5,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Colors.blue[500],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
