import 'package:flutter/material.dart';

// Define the enum for button states
enum QuizOptionState { unselected, selected, correct, wrong, disable }

class QuizOption extends StatelessWidget {
  const QuizOption(
      {super.key,
      required this.optionNumber,
      required this.statement,
      required this.optionState,
      required this.onClick});

  // The state of the widget as an enum
  final QuizOptionState optionState;
  final int optionNumber;
  final String statement;
  final Function onClick;

  // Find the color depending upon state
  Color findColor() {
    switch (optionState) {
      case QuizOptionState.unselected:
        return const Color.fromARGB(255, 0, 141, 206); // Default color
      case QuizOptionState.selected:
        return const Color.fromARGB(255, 226, 166, 0); // Color when selected
      case QuizOptionState.correct:
        return Colors.green; // Color when Correct
      case QuizOptionState.wrong:
        return Colors.red; // Color when the answer is wrong
      case QuizOptionState.disable:
        return Colors.grey; // Color when disabled
      default:
        return Colors.white; // Fallback color
    }
  }

  // Find the Character from Option Number
  String findOptionCharacter() {
    var characters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];
    return characters.elementAt(optionNumber - 1);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(findColor()), // Use the findColor method
      ),
      onPressed: () {
        onClick(optionNumber);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${findOptionCharacter()}.",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(width: 10),
            Text(
              statement,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
