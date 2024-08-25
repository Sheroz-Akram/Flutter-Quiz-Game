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

  get random => null;

  // Shuffle Quiz Options
  // Shuffle Quiz Options
  void shuffleQuiz() {
    // Create a list of indices from 0 to options.length - 1
    List<int> indices = List.generate(options.length, (index) => index);

    // Shuffle the indices
    indices.shuffle();

    // Store the new options and find the new index of the correct option
    List<String> shuffledOptions = List<String>.from(options);
    int newCorrectOption = indices.indexOf(correctOption);

    for (int i = 0; i < options.length; i++) {
      shuffledOptions[i] = options[indices[i]];
    }

    // Update options and correctOption with shuffled data
    options = shuffledOptions;
    correctOption = newCorrectOption;
  }

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

  // Shuffle Quiz Options
  void shuffleQuizOptions() {
    for (var quiz in quizList) {
      quiz.shuffleQuiz();
    }
  }
}
