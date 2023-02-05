import 'package:flutter/material.dart';
import 'package:qz/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzer',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

