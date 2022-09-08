
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = '/gameScreen';
  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<GameScreen> {
  late _Controller con;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where is the Flutter?'),
      ),
      body: const Text('TEST'),
    );
  }
}

class _Controller {
  late _GameState state;
  _Controller(this.state);
}