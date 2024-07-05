import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'colors.dart';

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

  @override
  Widget build(BuildContext context) {
    final discountValue = discount ?? "0";
    final double originalPrice = double.tryParse(s_price) ?? 0;
    final double discountPercentage = double.tryParse(discountValue) ?? 0;
    final double discountedPrice = originalPrice - (originalPrice * (discountPercentage / 100));
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
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
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
                    padding: EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                          color: Colors.grey.shade100,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Text(
                          s_name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.grey.shade800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          s_desc,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
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
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.appiconColor,
                                        ),
                                        children: [
                                          TextSpan(text: 'السعر: '),
                                          TextSpan(
                                            text: s_price,
                                            style: TextStyle(
                                              decoration: int.parse(discountValue) != 0 ? TextDecoration.lineThrough : null,
                                              decorationColor: Colors.white,
                                              decorationThickness: 2.0,
                                            ),
                                          ),
                                          TextSpan(text: ' ل.س  '),
                                        ],
                                      ),
                                    )
                                    /*Text(
                                      'ل.س',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.appiconColor,
                                        decoration: TextDecoration.lineThrough, // Add line-through decoration
                                        decorationColor: Colors.white, // Set line color to white
                                        decorationThickness: 2.0,
                                      ),
                                    )*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: int.parse(discountValue) != 0,
              child: Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '% $discountValue', // Show discount value in the ribbon
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

            ),
            Visibility(
              visible: int.parse(discountValue) != 0,
              child: Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'السعر: $discountedPrice ل.س',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

