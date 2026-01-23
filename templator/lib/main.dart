import 'package:flutter/material.dart';
import 'package:templator/views/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Templator',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo)),
      home: MainView(title: 'Text Templator'),
    );
  }
}
