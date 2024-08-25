import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_game/QuizPage.dart';

class Resultpage extends StatefulWidget {
  const Resultpage(
      {super.key,
      required this.correctQuizCount,
      required this.totalCount,
      required this.level});
  final int correctQuizCount;
  final int totalCount;
  final int level;
  @override
  State<StatefulWidget> createState() {
    return _ResultPage();
  }
}

class _ResultPage extends State<Resultpage> {
  // Feed Back Messages
  List<List<String>> feedbackMessages = [
    // Good Score Messages
    [
      "Amazing job! You really know your stuff!",
      "Fantastic! You're a quiz master in the making!",
      "Outstanding performance! You've nailed it!"
    ],
    // Medium Score Messages
    [
      "Good effort! You’re almost there. Keep it up!",
      "Nice try! With a bit more practice, you'll ace it!",
      "Not bad! You're on the right track. Keep pushing!"
    ],
    // Bad Score Messages
    [
      "Don't worry, every expert was once a beginner. Try again!",
      "It's okay, learning is a journey. Keep going!",
      "Keep practicing, and you'll get better next time!"
    ]
  ];

  // Get Feedback Message from Score
  String feebackMessage(int quizCorrent, int totalQuizCount) {
    // Caluculate Percentage
    double scorePercentage = (quizCorrent / totalQuizCount) * 100;

    // Deternmine Feedback and Return
    Random random = Random();
    if (scorePercentage >= 80) {
      return feedbackMessages[0][random.nextInt(feedbackMessages[0].length)];
    } else if (scorePercentage >= 50) {
      return feedbackMessages[1][random.nextInt(feedbackMessages[1].length)];
    } else {
      return feedbackMessages[2][random.nextInt(feedbackMessages[2].length)];
    }
  }

  // Get the Image to Display
  String faceImage(int quizCorrent, int totalQuizCount) {
    // Caluculate Percentage
    double scorePercentage = (quizCorrent / totalQuizCount) * 100;

    // Deternmine Feedback and Return
    if (scorePercentage >= 80) {
      return "assets/challenge.png";
    } else if (scorePercentage >= 50) {
      return "assets/expecting.png";
    } else {
      return "assets/disappointed.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF251554),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Score:  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "0${widget.correctQuizCount}/0${widget.totalCount}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  faceImage(widget.correctQuizCount, widget.totalCount),
                  width: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  feebackMessage(widget.correctQuizCount, widget.totalCount),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white),
                        ),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.green)),
                    onPressed: () {
                      // Exit and Reload the Game
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QuizPage(level: widget.level)));
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white),
                        ),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      // Exit the Game
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Exit Game",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
