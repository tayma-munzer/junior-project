import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/rating.dart';

class ItemDetails extends StatelessWidget {
  final String image;
  final String serviceTitle;
  final String description;
  final String price;
  final String duration;
  final String numberOfBuyers;
  final String status;
  final String discount;

  ItemDetails({
    required this.image,
    required this.serviceTitle,
    required this.description,
    required this.price,
    required this.duration,
    required this.numberOfBuyers,
    required this.status,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final discountValue = discount ?? "0";
    final double originalPrice = double.tryParse(price) ?? 0;
    final double discountPercentage = double.tryParse(discountValue) ?? 0;
    final double discountedPrice = originalPrice - (originalPrice * (discountPercentage / 100));
    Widget imageWidget;

    // Assuming you have the image data available
    if (image != null && image.isNotEmpty) {
      try {
        Uint8List imageData = base64Decode(image);
        imageWidget = Image.memory(
          imageData,
          height: 300,
          width: double.infinity,
        );
      } catch (error) {
        print('Error decoding base64 image: $error');
        // Placeholder widget if decoding fails
        imageWidget = Container(
          height: 100,
          color: Colors.grey,
        );
      }
    } else {
      // Placeholder widget if image is null or empty
      imageWidget = Container(
        height: 100,
        color: Colors.grey,
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            imageWidget,
            SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RatingWidget2(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            serviceTitle,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        /**/

                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[700],
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'احصل على الخدمة خلال',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          duration,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.grey[700],
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "السعر",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        Spacer(),
                        Text(
                          '  $discountedPrice   ل.س',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    if (discount != '0')
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.discount_outlined,
                                color: Colors.grey[700],
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "الخصم",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle:FontStyle.italic,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                ' % $discount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Colors.grey[700],
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "عدد المشترين",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          numberOfBuyers,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "التوصيف",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10,),
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
