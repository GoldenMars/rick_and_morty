import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc_observable.dart';
import 'package:rick_and_morty/ui/pages/home_page.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: CharacterBlocObservable(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: HomePage(title: 'Rick and Morty'),
    );
  }
}
