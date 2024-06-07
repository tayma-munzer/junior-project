import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';

class BuildItem extends StatelessWidget {
  final String s_name;
  final String s_desc;
  final String? image;
  final String s_price;
  final String? discount;
  final String? status;

  BuildItem(
      this.s_name,
      this.s_desc,
      this.image,
      this.s_price,
      this.discount,
      this.status,
      );

  factory BuildItem.without2(
      String s_name,
      String s_desc,
      String image,
      String s_price,
      ) {
    return BuildItem(s_name, s_desc, image, s_price, null, null);
  }

  @override
  Widget build(BuildContext context) {
    final discountValue =
        discount ?? "0"; // Use 0 as default if discount is null

    Widget buildImageWidget() {
      if (image != null && image!.isNotEmpty) {
        try {
          String paddedImage = image!.padRight((image!.length + 3) ~/ 4 * 4, '=');
          Uint8List imageData = base64Url.decode(paddedImage);
          return Image.memory(
            imageData,
            height: 300,
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
                      s_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      s_desc,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'السعر: $s_price ل.س',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      'خصم: $discountValue%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      'الحالة: $status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
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
