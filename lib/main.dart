import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_game/WelcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF251554),
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz Game',
        theme: ThemeData(
          textTheme: GoogleFonts.signikaNegativeTextTheme(),
          useMaterial3: true,
        ),
        home: const WelcomePage());
  }
}
