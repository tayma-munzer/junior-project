import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile/colors.dart';

class CategoryWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final Widget page;

  const CategoryWidget({
    Key? key,
    required this.icon,
    required this.size,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Get.to(page);
          },
          splashColor: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appColor,
            ),
            child: Icon(
              icon,
              size: size,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
