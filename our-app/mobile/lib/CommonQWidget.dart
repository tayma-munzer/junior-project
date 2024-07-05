import 'package:flutter/material.dart';

class CommonQuestions extends StatelessWidget {
  final String question;
  final String answer;

  CommonQuestions({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(10),
              child: Text(
                question,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
