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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizPage(level: 02)));
                },
                child: const Text("open quiz"))
          ],
        ),
      ),
    ));
  }
}
