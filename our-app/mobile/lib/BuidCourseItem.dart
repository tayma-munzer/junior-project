import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'colors.dart';

class BuildCourseItem extends StatelessWidget {

  final String c_name;
  final String c_desc;
  final String c_price;
  final String? image;
  final String pre_requisite;

  BuildCourseItem(

      this.c_name,
      this.c_desc,
      this.c_price,
      this.image,
      this.pre_requisite
      );

  @override
  Widget build(BuildContext context) {
    Widget buildImageWidget() {
      if (image != null && image!.isNotEmpty) {
        try {
          String paddedImage = image!.padRight((image!.length + 3) ~/ 4 * 4, '=');
          Uint8List imageData = base64Url.decode(paddedImage);
          return Image.memory(
            imageData,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        } catch (error) {
          print('Error decoding base64 image: $error');
        }
      }
      // Placeholder widget if image is null or empty, or if decoding fails
      return Container(
        height: 100,
        color: Colors.grey,
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: [
                if (image != null) buildImageWidget(),
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: const EdgeInsets.all(25.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      c_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      c_desc,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),

                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السعر: $c_price ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.appiconColor,
                                  ),
                                ),
                                Text(
                                  'ل.س',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.appiconColor,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 50,
                            height: 43,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                pre_requisite,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),),),
                      ],
                    ),

                  ],
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
