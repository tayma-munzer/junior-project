import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';

class BuildItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageUrl;
  final double rating;

  BuildItem(
    this.title,
    this.subTitle,
    this.imageUrl,
    this.rating,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            height: 180.0,
            width: double.infinity,
            loadingBuilder: (context, imageProvider, loadingProgress) {
              if (loadingProgress == null) {
                // Image is loaded, return the image widget itself
                return imageProvider; // Use imageProvider directly here
              }
              return Center(
                child: CircularProgressIndicator(),
              ); // Show a spinner while loading
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text('Error loading image'),
              ); // Display error message
            },
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.appColor,
                  child: Text(
                    rating.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
