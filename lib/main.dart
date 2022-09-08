import 'package:flutter/material.dart';
import 'package:project2/viewscreen/game_screen.dart';

void main() {
  runApp(const WhereIsFlutterApp());
}

class WhereIsFlutterApp extends StatelessWidget {
  const WhereIsFlutterApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: GameScreen.routeName,
      routes: {
        GameScreen.routeName:(context) => const GameScreen(),
      }
    );
  }

}