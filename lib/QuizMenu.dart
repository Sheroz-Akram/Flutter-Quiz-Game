import 'package:flutter/material.dart';
import 'package:flutter_quiz_game/QuizOption.dart';

class QuizMenu extends StatefulWidget {
  const QuizMenu(
      {super.key,
      required this.question,
      required this.options,
      required this.correctAnswerIndex,
      required this.onOptionSelect});

  // Quiz Details
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final Function onOptionSelect;

  @override
  _QuizMenuState createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  int? selectedOptionIndex;
  List<QuizOptionState> optionStates = [];
  bool isCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    resetQuizState();
  }

  @override
  void didUpdateWidget(covariant QuizMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the quiz state when the widget is updated with new quiz details
    if (oldWidget.question != widget.question) {
      resetQuizState();
    }
  }

  // Reset Quiz Menu to Orignal State
  void resetQuizState() {
    selectedOptionIndex = null;
    isCorrectAnswer = false;
    optionStates = List<QuizOptionState>.filled(
        widget.options.length, QuizOptionState.unselected);
  }

  // Ootion Selected in Quiz
  void handleOptionSelection(int index) {
    setState(() {
      if (selectedOptionIndex != null) {
        return;
      }

      selectedOptionIndex = index;

      if (index == widget.correctAnswerIndex) {
        optionStates[index] = QuizOptionState.correct;
        isCorrectAnswer = true;
      } else {
        optionStates[index] = QuizOptionState.wrong;
        optionStates[widget.correctAnswerIndex] = QuizOptionState.correct;
      }

      for (int i = 0; i < optionStates.length; i++) {
        if (i != index && i != widget.correctAnswerIndex) {
          optionStates[i] = QuizOptionState.disable;
        }
      }
    });
    widget.onOptionSelect(isCorrectAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        // Loop through the list of options and create a QuizOption widget for each option
        ...widget.options.asMap().entries.map((entry) {
          int index = entry.key;
          String optionText = entry.value;

          return QuizOption(
            optionNumber: index + 1,
            statement: optionText,
            optionState: optionStates[index],
            onClick: (optionNumber) {
              handleOptionSelection(optionNumber - 1);
            },
          );
        }),
      ],
    );
  }
}
