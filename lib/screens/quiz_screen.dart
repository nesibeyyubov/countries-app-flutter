import 'package:countries_app/utils/quiz_type.dart';
import 'package:countries_app/widgets/quiz_item.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  static const routeName = "quiz-screen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Quiz",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  QuizItem(
                    type:QuizType.Capitals,
                    title: "Capitals Quiz",
                    subtitle: "Find the capital of country",
                    overlayColor: Theme.of(context).primaryColor,
                  ),
                  QuizItem(
                    type:QuizType.Flags,
                    title: "Flags Quiz",
                    subtitle: "Find the country matches given flag",
                    overlayColor: Color(0xFF662D),
                  ),
                  QuizItem(
                    type:QuizType.Regions,
                    title: "Regions Quiz",
                    subtitle: "Find the country located in given region",
                    overlayColor: Color(0x005D9F),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
