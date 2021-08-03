import 'package:countries_app/utils/quiz_type.dart';
import 'package:countries_app/widgets/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = "quiz-screen";

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  int _capitalsBestScore = 0;
  int _flagsBestScore = 0;
  int _regionsBestScore = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences.getInstance().then((prefs) {
        print("prefs object got : ${prefs}");
        setState(() {
          _capitalsBestScore = prefs.getInt("capitalsBestScore") ?? 0;
          _flagsBestScore = prefs.getInt("flagsBestScore") ?? 0;
          _regionsBestScore = prefs.getInt("regionsBestScore") ?? 0;
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
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
                          bestScore: _capitalsBestScore,
                          type: QuizType.Capitals,
                          title: "Capitals Quiz",
                          subtitle: "Find the capital of country",
                          overlayColor: Theme.of(context).primaryColor,
                        ),
                        QuizItem(
                          bestScore: _flagsBestScore,
                          type: QuizType.Flags,
                          title: "Flags Quiz",
                          subtitle: "Find the country matches given flag",
                          overlayColor: Color(0xFF662D),
                        ),
                        QuizItem(
                          bestScore: _regionsBestScore,
                          type: QuizType.Regions,
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
