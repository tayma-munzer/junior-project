import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStars extends StatelessWidget {
  final String rate;

  RatingStars({required this.rate});

  @override
  Widget build(BuildContext context) {
    double rating = double.tryParse(rate) ?? 0;

    return RatingBar.builder(
      initialRating: rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24.0,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (_) {
        // Placeholder function
      },
    );
  }
}
