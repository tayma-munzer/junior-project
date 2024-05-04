import 'package:flutter/material.dart';

class BuildItem extends StatelessWidget {
  final String s_name;
  final String s_desc;
  final String s_img;
  final String s_price;
  final String discount;
  final String status;

  BuildItem(
    this.s_name,
    this.s_desc,
    this.s_img,
    this.s_price,
    this.discount,
    this.status,
  );

  @override
  Widget build(BuildContext context) {
    final discountValue =
        discount ?? "0"; // Use 0 as default if discount is null
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
          mainAxisSize:
              MainAxisSize.min, // Set mainAxisSize to MainAxisSize.min
          children: <Widget>[
            Stack(
              children: [
                Image(
                  image: NetworkImage(s_img),
                  fit: BoxFit.cover,
                  height: 180.0,
                  width: double.infinity,
                  loadingBuilder: (context, imageProvider, loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is loaded, return the image widget itself
                      return imageProvider;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show a spinner while loading
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Error loading image'),
                    ); // Display error message
                  },
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.loose, // Use FlexFit.loose for flexible child
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
