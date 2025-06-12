import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: HomePage(title: 'Rick and Morty'),
    );
  }
}
