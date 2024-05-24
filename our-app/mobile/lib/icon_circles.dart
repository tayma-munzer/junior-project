import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:string_2_icon/string_2_icon.dart';

class CircleItem extends StatelessWidget {
  final dynamic data;
  final Function onTap;
  final String iconKey;

  const CircleItem({
    required this.data,
    required this.onTap,
    required this.iconKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          splashColor: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appColor,
            ),
            child: Icon(
              String2Icon.getIconDataFromString(
                  data[iconKey]), // Use the iconKey parameter
              color: AppColors.appiconColor,
              size: MediaQuery.of(context).size.width / 6,
            ),
          ),
        ),
      ),
    );
  }
}
