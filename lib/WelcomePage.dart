import 'package:flutter/material.dart';
import 'package:flutter_quiz_game/QuizPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _WelcomePage();
  }
}

class _WelcomePage extends State<WelcomePage> {
  // List of levels
  final List<String> levels = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5'
  ];
  String selectedLevel = 'Level 1'; // The selected level

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF251554),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: 100,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Welcome to Quiz Game",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                DropdownButton<String>(
                  dropdownColor: Colors.black,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  hint: const Text(
                    'Select Level',
                  ),
                  value: selectedLevel, // Current selected value
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLevel = newValue!; // Update the selected value
                    });
                  },
                  items: levels.map<DropdownMenuItem<String>>((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(
                        level,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Start Quiz Button
                ElevatedButton(
                    style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          const BorderSide(color: Colors.white),
                        ),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(
                                  level: levels.indexOf(selectedLevel) + 1)));
                    },
                    child: const Text(
                      "Start Quiz",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
