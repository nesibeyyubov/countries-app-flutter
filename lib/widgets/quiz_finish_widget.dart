import 'package:flutter/material.dart';

class QuizFinishWidget extends StatelessWidget {
  final int correctAnswerCount;

  QuizFinishWidget(this.correctAnswerCount);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Quiz is finished !",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Your score is: ${correctAnswerCount*10}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40,),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(side: BorderSide(color: Theme.of(context).primaryColor,width: 1)),
            child: Text(
              "Exit",
              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
