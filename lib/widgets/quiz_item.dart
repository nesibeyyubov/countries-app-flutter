import 'package:countries_app/screens/question_screen.dart';
import 'package:countries_app/utils/quiz_type.dart';
import 'package:flutter/material.dart';

class QuizItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color overlayColor;
  final QuizType type;
  final int bestScore;

  QuizItem({required this.type,required this.title,required this.subtitle,required this.overlayColor,required this.bestScore});

  void onQuizItemSelected(BuildContext context){
    Navigator.of(context).pushNamed(QuestionScreen.routeName,arguments: type );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12)
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/flags.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: overlayColor.withOpacity(0.7)),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    )),
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "240+",
                          style: TextStyle(
                              fontSize: 32, color: Colors.black),
                        ),
                        const Text(
                          "Question count",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          bestScore.toString(),
                          style: TextStyle(
                              fontSize: 32, color: Colors.black),
                        ),
                        const Text(
                          "Your best score",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "60 seconds",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black),
                    ),
                    const Text(
                      "duration",
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  onPressed: ()=>onQuizItemSelected(context),
                  child: Text(
                    "PLAY",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 45,
                  minWidth: double.infinity,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
