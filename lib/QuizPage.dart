import 'package:flutter/material.dart';
import 'package:flutter_quiz_game/QuizManager.dart';
import 'package:flutter_quiz_game/QuizMenu.dart';
import 'package:flutter_quiz_game/ResutlPage.dart';

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
  int correctAnswerCount = 0;
  bool isCorrectAnswer = false;
  bool isAnswered = false;
  late QuizManager quizManager;
  List<Quiz> quizList = [];

  @override
  void initState() {
    super.initState();
    // Load Quizs
    quizManager = QuizManager(totalQuiz: totalQuiz, level: widget.level);
    quizManager.loadQuizs();
    quizManager.shuffleQuizOptions();
    setState(() {
      quizList = quizManager.quizList;
    });
  }

  // Display Message on Screen
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 51, 29, 116),
        content: Text(
          message,
          style: const TextStyle(color: Colors.red),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF251554),
          body: SingleChildScrollView(
            child: Container(
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
                  quizList.isEmpty
                      ? const Text("Loading Quiz List")
                      : QuizMenu(
                          question: quizList[currentQuiz].question,
                          options: quizList[currentQuiz].options,
                          correctAnswerIndex:
                              quizList[currentQuiz].correctOption,
                          onOptionSelect: (answerStatus) {
                            setState(() {
                              if (!isAnswered) {
                                isCorrectAnswer = answerStatus;
                                if (answerStatus) {
                                  correctAnswerCount++;
                                }
                              }
                              isAnswered = true;
                            });
                          },
                        ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Button To Go To Next Quiz
                  isAnswered
                      ? Center(
                          child: Column(
                            children: [
                              Image.asset(
                                isCorrectAnswer
                                    ? "assets/correct.png"
                                    : "assets/wrong.png",
                                width: 100,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Button to Move to Next Page
                              ElevatedButton(
                                  style: ButtonStyle(
                                      side: WidgetStateProperty.all(
                                        const BorderSide(color: Colors.white),
                                      ),
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                              Color.fromARGB(
                                                  255, 51, 29, 116))),
                                  onPressed: () {
                                    setState(() {
                                      if (!isAnswered) {
                                        displayMessage(
                                            "Please Choose Option to Move to Next");
                                      } else {
                                        if (currentQuiz < totalQuiz - 1) {
                                          currentQuiz++;
                                          isAnswered = false;
                                          isCorrectAnswer = false;
                                        } else {
                                          // Navigate to Result Screen
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Resultpage(
                                                          correctQuizCount:
                                                              correctAnswerCount,
                                                          totalCount:
                                                              totalQuiz)));
                                        }
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "Next Quiz",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        )
                ],
              ),
            ),
          )),
    );
  }
}
