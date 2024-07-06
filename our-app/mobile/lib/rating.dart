import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget2 extends StatefulWidget {
  static _RatingWidget2State? ratingWidget2State; // Add this line

  @override
  _RatingWidget2State createState() {
    var state = _RatingWidget2State();
    ratingWidget2State = state; // Assign the state instance to the static variable
    return state;
  }

  static double getRating() {
    return ratingWidget2State?.rating ?? 0;
  }
}

class _RatingWidget2State extends State<RatingWidget2> {
  double rating = 5; // Initial rating value

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar.builder(
          initialRating: rating, // Use the rating variable here
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 18,
          itemPadding: EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (newRating) {
            setState(() {
              rating = newRating; // Update the rating value
            });
          },
        ),
        SizedBox(width: 5), // Adding space between the stars and the number
        Text(
          rating.toString(), // Display the rating value
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
