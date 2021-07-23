import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = "question-screen";

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(7, 162, 128, 1),
                  Color.fromRGBO(6, 118, 93, 1),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question 01",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "X",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ))
                      ],
                    ),
                    Center(
                        child: Text(
                      '"Berlin" is the capital of ...',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    )),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
