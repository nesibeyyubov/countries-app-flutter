import 'package:countries_app/utils/quiz_type.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizFinishWidget extends StatefulWidget {
  final int correctAnswerCount;
  final QuizType quizType;

  QuizFinishWidget(this.correctAnswerCount, this.quizType);

  @override
  _QuizFinishWidgetState createState() => _QuizFinishWidgetState();
}

class _QuizFinishWidgetState extends State<QuizFinishWidget> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        switch (widget.quizType) {
          case QuizType.Capitals:
            int bestScore = prefs.getInt("capitalsBestScore") ?? 0;
            if(widget.correctAnswerCount > bestScore){
              prefs.setInt("capitalsBestScore", widget.correctAnswerCount);
            }
            break;
          case QuizType.Regions:
            int bestScore = prefs.getInt("regionsBestScore") ?? 0;
            if(widget.correctAnswerCount > bestScore){
              prefs.setInt("regionsBestScore", widget.correctAnswerCount).then((_)=>print("regions set best score"));
            }
            break;
          case QuizType.Flags:
            int bestScore = prefs.getInt("flagsBestScore") ?? 0;
            if(widget.correctAnswerCount > bestScore){
              prefs.setInt("flagsBestScore", widget.correctAnswerCount);
            }
            break;
        }
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Quiz is finished !",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Your score is: ${widget.correctAnswerCount}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            child: Text(
              "Exit",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
