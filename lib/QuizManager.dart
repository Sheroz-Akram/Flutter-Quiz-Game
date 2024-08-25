import 'package:flutter_quiz_game/Quizs.dart';
import 'package:flutter_quiz_game/RandomNumbers.dart';

class Quiz {
  Quiz({
    required this.question,
    required this.options,
    required this.correctOption,
  });

  String question;
  List<String> options;
  int correctOption;

  // Display Quiz Information
  void display() {
    print("Question: $question");
    print("Options: $options");
    print("CorectOption: ${options[correctOption]}");
  }
}

class QuizManager {
  QuizManager({required this.totalQuiz, required this.level});

  // Parameters
  int totalQuiz;
  int level;
  List<Quiz> quizList = [];

  // Load Quiz from List
  void loadQuizs() {
    // Select Random Quiz from Level
    var randomList = generateUniqueRandomNumbers(
        0, quizQuestions[level - 1].length, totalQuiz);
    // Choose Quiz from these random numbers and Store them
    for (var i = 0; i < randomList.length; i++) {
      var currentQuiz = quizQuestions[level - 1][randomList[i]];
      quizList.add(Quiz(
          question: currentQuiz['question'],
          options: currentQuiz['options'],
          correctOption: currentQuiz['correctIndex']));
    }
  }
}
