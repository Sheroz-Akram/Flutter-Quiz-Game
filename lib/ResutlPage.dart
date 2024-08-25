import 'package:flutter/material.dart';

class Resultpage extends StatefulWidget {
  const Resultpage(
      {super.key, required this.correctQuizCount, required this.totalCount});
  final int correctQuizCount;
  final int totalCount;
  @override
  State<StatefulWidget> createState() {
    return _ResultPage();
  }
}

class _ResultPage extends State<Resultpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Text(
            "Correct Answer: ${widget.correctQuizCount}/${widget.totalCount}"),
      ),
    ));
  }
}
