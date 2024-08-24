import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_game/QuizMenu.dart';
import 'package:flutter_quiz_game/Quizs.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.level});
  final int level;
  @override
  State<StatefulWidget> createState() {
    return _QuizPage();
  }
}

class _QuizPage extends State<QuizPage> {
  // Quiz Information
  int totalQuiz = 5;
  int currentQuiz = 0;
  late var completeQuizList = [];

  // Generate List of Random Number
  List<int> generateUniqueRandomNumbers(int start, int end, int size) {
    if (size <= 0) {
      throw ArgumentError('Size must be greater than 0.');
    }
    if (start >= end) {
      throw ArgumentError('Start must be less than end.');
    }
    if (size > (end - start)) {
      throw ArgumentError(
          'Size must be less than or equal to the range between start and end.');
    }

    Random random = Random();
    Set<int> uniqueNumbers = <int>{};

    while (uniqueNumbers.length < size) {
      int number = random.nextInt(end - start) + start;
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }

  // Function to Load Quizes
  void loadQuizs(int level, int Size) {
    // Select Random Quiz from Level
    var randomList =
        generateUniqueRandomNumbers(0, quizQuestions[level - 1].length, Size);
    // Choose Quiz from these random
    List<dynamic> quizList = [];
    for (var i = 0; i < randomList.length; i++) {
      quizList.add(quizQuestions[level - 1][randomList[i]]);
    }
    setState(() {
      completeQuizList = quizList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadQuizs(widget.level, totalQuiz);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF251554),
          body: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Level 0${widget.level}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "0${currentQuiz + 1}/0$totalQuiz",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),

                // Our Quiz Menu Here
                completeQuizList.isEmpty
                    ? const Text("Loading")
                    : QuizMenu(
                        question: completeQuizList[currentQuiz]['question'],
                        options: completeQuizList[currentQuiz]['options'],
                        correctAnswerIndex: completeQuizList[currentQuiz]
                            ['correctIndex'],
                        onOptionSelect: (isCorrectAnswer) {
                          print("Status: $isCorrectAnswer");
                        },
                      ),
              ],
            ),
          )),
    );
  }
}
