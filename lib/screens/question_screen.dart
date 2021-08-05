import 'dart:async';
import 'dart:math';

import 'package:countries_app/models/country.dart';
import 'package:countries_app/models/question.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/utils/quiz_type.dart';
import 'package:countries_app/widgets/quiz_answer_item.dart';
import 'package:countries_app/widgets/quiz_finish_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = "question-screen";

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  Question? _currentQuestion;
  bool _quizStarted = false;
  int _currentQuestionIndex = 0;
  bool _questionAnswered = false;
  int _leftSeconds = 60;
  bool _quizFinished = false;
  Timer? quizTimer;
  int _currentAnswerCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Countries>(context, listen: false)
          .getAllCountries()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    quizTimer?.cancel();
  }

  void makeQuestion(List<Country> countries, QuizType quizType) {
    if (!_quizStarted) {
      quizTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          if (_leftSeconds == 0) {
            setState(() {
              _quizFinished = true;
            });
          } else {
            _leftSeconds = _leftSeconds - 1;
          }
        });
      });
    }

    var randomAnswerIndex = Random().nextInt(countries.length - 1);
    var randomAnswerCountry = countries[randomAnswerIndex];
    var randomWrongAnswerIndex1 = Random().nextInt(countries.length - 1);
    while (randomWrongAnswerIndex1 == randomAnswerIndex) {
      randomWrongAnswerIndex1 = Random().nextInt(countries.length - 1);
    }
    var randomWrongAnswerIndex2 = Random().nextInt(countries.length - 1);
    while (randomWrongAnswerIndex2 == randomAnswerIndex ||
        randomWrongAnswerIndex2 == randomWrongAnswerIndex1) {
      randomWrongAnswerIndex2 = Random().nextInt(countries.length - 1);
    }
    var randomWrongAnswerIndex3 = Random().nextInt(countries.length - 1);
    while (randomWrongAnswerIndex3 == randomAnswerIndex ||
        randomWrongAnswerIndex3 == randomWrongAnswerIndex2 ||
        randomWrongAnswerIndex3 == randomWrongAnswerIndex1) {
      randomWrongAnswerIndex3 = Random().nextInt(countries.length - 1);
    }

    var randomWrongAnswer1 = countries[randomWrongAnswerIndex1];
    var randomWrongAnswer2 = countries[randomWrongAnswerIndex2];
    var randomWrongAnswer3 = countries[randomWrongAnswerIndex3];

    Question question;
    switch (quizType) {
      case QuizType.Flags:
        {
          var options = [
            randomWrongAnswer1.name,
            randomWrongAnswer2.name,
            randomWrongAnswer3.name,
            randomAnswerCountry.name
          ];
          options.shuffle();
          question = Question(
            answer: randomAnswerCountry.name,
            options: options,
            flag: randomAnswerCountry.flag,
          );
          break;
        }
      case QuizType.Regions:
        {
          var options = [
            randomWrongAnswer1.name,
            randomWrongAnswer2.name,
            randomWrongAnswer3.name,
            randomAnswerCountry.name
          ];
          options.shuffle();
          question = Question(
            answer: randomAnswerCountry.name,
            options: options,
            text: 'Which country is located in "${randomAnswerCountry.region}"',
          );
          break;
        }
      case QuizType.Capitals:
        {
          var options = [
            randomWrongAnswer1.name,
            randomWrongAnswer2.name,
            randomWrongAnswer3.name,
            randomAnswerCountry.name
          ];
          options.shuffle();
          question = Question(
            answer: randomAnswerCountry.name,
            options: options,
            text: '"${randomAnswerCountry.capital}" is the capital of ...',
          );
          break;
        }
    }
    setState(() {
      _currentQuestion = question;
      _currentQuestionIndex = _currentQuestionIndex + 1;
      _questionAnswered = false;
      if (!_quizStarted) {
        _quizStarted = true;
      }
    });
  }

  void onOptionsItemSelected(bool isRightQuestion) {
    setState(() {
      _questionAnswered = true;
      if (isRightQuestion) {
        _currentAnswerCount = _currentAnswerCount + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizType = ModalRoute.of(context)?.settings.arguments as QuizType;
    final countriesData = Provider.of<Countries>(context);
    final countries = countriesData.countries;

    return Scaffold(
      body: SafeArea(
        child: _quizFinished
            ? QuizFinishWidget(_currentAnswerCount, quizType)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                            Color.fromRGBO(7, 162, 128, 1),
                            Color.fromRGBO(6, 118, 93, 1),
                          ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Question $_currentQuestionIndex",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "X",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ))
                            ],
                          ),
                          _isLoading
                              ? Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: CircularProgressIndicator(
                                    color: const Color(0xFFFEC107),
                                  ))
                              : countriesData.allCountriesError != null
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 40),
                                      child: Text(
                                        countriesData.allCountriesError!,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ))
                                  : !_quizStarted
                                      ? Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: const Text(
                                            "Click start to start the game",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ))
                                      : quizType == QuizType.Flags
                                          ? Container(
                                              margin: const EdgeInsets.only(top: 30),
                                              child: SvgPicture.network(
                                                _currentQuestion!.flag!,
                                                width: 150,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ))
                                          : Container(
                                              margin: const EdgeInsets.only(top: 50),
                                              child: Text(
                                                _currentQuestion!.text!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                        ]),
                      )),
                  Container(
                    transform: Matrix4.translationValues(0, -30, 0),
                    margin: const EdgeInsets.only(right: 15, bottom: 30),
                    alignment: Alignment.centerRight,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFEC107),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        _leftSeconds.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  if (_quizStarted)
                    Container(
                      transform: Matrix4.translationValues(0, -40, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: List.generate(
                              _currentQuestion!.options.length,
                              (index) => QuizAnswerItem(
                                  onOptionsItemSelected: onOptionsItemSelected,
                                  isAnswered: _questionAnswered,
                                  isRightQuestion:
                                      _currentQuestion!.options[index] ==
                                          _currentQuestion!.answer,
                                  optionText: _currentQuestion!.options[index],
                                  variant: index)),
                        ),
                      ),
                    ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(10)),
                      onPressed: _isLoading || countriesData.allCountriesError != null
                          ? null
                          : () => makeQuestion(countries, quizType),
                      child: Text(
                        _quizStarted ? "NEXT" : "START",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
