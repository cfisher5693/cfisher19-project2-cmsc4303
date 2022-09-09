
import 'package:flutter/material.dart';

import '../model/fluttergame_model.dart';

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
  late FlutterGame gameModel;
  final List<Widget> images = [
    Image.asset('images/back.png'),
    Image.asset('images/flutter.png'),
    Image.asset('images/blank.png'),
  ];
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    gameModel = FlutterGame();
    gameModel.generateKey();
  }
  void render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where is the Flutter?'),
        actions: [
          ElevatedButton(onPressed: con.hideKey, child: const Text('Hide Key'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(!gameModel.secret) Container(
                color: Colors.black,
                child: Text('SECRET: The Flutter is at Card-${gameModel.location}', style: const TextStyle(color: Colors.yellow, fontSize: 20,),),
              ),
              const SizedBox(height: 20,),
              Text('Balance: ${gameModel.balance} coins (Debts: ${gameModel.debt} coins)', style: Theme.of(context).textTheme.headline5,),
              Row(
                children: [
                  if(gameModel.mode == 0)
                    for(int i = 0; i < 3; i++)
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 220,
                          width: 120,
                          child: images[0],
                        ),
                      ),
                  if(gameModel.mode == 1)
                    for(int i = 0; i < 3; i++)
                      con.displayCards(i),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 28.0,
                    runSpacing: 10.0,
                    children: [
                  for(int i = 0; i < 3; i++)
                    Container(
                      color: Colors.blue[200],
                      child: Row(
                        children: [
                          IconButton(onPressed: () => con.subtractBet(i), icon: const Icon(Icons.remove),),
                          Text('${gameModel.bets[i].toString()}'),
                          IconButton(onPressed: () => con.addBet(i), icon: const Icon(Icons.add),),
                        ],
                      ),
                    ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              con.displayButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  late _GameState state;
  _Controller(this.state);

  Widget displayButtons() {
    if(state.gameModel.mode == 0) {
      return ElevatedButton(onPressed: onPlay, child: const Text('Play', style: const TextStyle(color: Colors.yellow, fontSize: 30),), style: ElevatedButton.styleFrom(primary: Colors.grey[300]),);
    } else {
      if(state.gameModel.balance == 0) {
        return Column(
          children: [
            const ElevatedButton(onPressed: null, child: Text('New Game'),),
            const SizedBox(height: 30,),
            Text('You Won: ${state.gameModel.bets[state.gameModel.location]} (bet) x 3 = ${state.gameModel.bets[state.gameModel.location]*3} coins(s)', style: const TextStyle(fontSize: 18),),
            const Text('No Balance. Loan to Pay.', style: TextStyle(fontSize: 18),),
            ElevatedButton(onPressed: loanCoins, child: const Text('Borrow 8 Coins'),),
          ]
        );
      } else {
        return Column(
          children: [
            ElevatedButton(onPressed: newGame, child: const Text('New Game'),),
            const SizedBox(height: 30,),
            Text('You Won: ${state.gameModel.bets[state.gameModel.location]} (bet) x 3 = ${state.gameModel.bets[state.gameModel.location]*3} coins(s)', style: const TextStyle(fontSize: 18),),
          ]
        );
      }
    }
  }

  Widget displayCards(int i) {
    if(state.gameModel.key[i] == 0) {
      return Expanded(
              flex: 1,
              child: SizedBox(
                height: 220,
                  width: 120,
                  child: state.images[2],
              ),
      );
    } else {
      return Expanded(
              flex: 1,
              child: SizedBox(
                height: 220,
                  width: 120,
                  child: state.images[1],
              ),
      );
    }
  }

  void onPlay() {
    state.render(() {
      state.gameModel.mode = 1;
      state.gameModel.checkBets();
    });
  }

  void addBet(int i) {
    state.render(() {
      if(state.gameModel.bets[i] < 3 && state.gameModel.balance != 0) {
        state.gameModel.bets[i]++;
        state.gameModel.balance--;
      }
    });
  }

  void subtractBet(int i) {
    state.render(() {
      if(state.gameModel.bets[i] != 0) {
        state.gameModel.bets[i]--;
        state.gameModel.balance++;
      }
    });
  }

  void newGame() {
    state.render(() {
      state.gameModel.mode = 0;
      for(int i = 0; i < 3; i++) {
        state.gameModel.key[i] = 0;
        state.gameModel.bets[i] = 0;
      }
      state.gameModel.generateKey();
    });
  }

  void loanCoins() {
    state.render(() {
      state.gameModel.balance += 8;
      state.gameModel.debt += 8;
      newGame();
    });
  }

  void hideKey() {
    state.render(() {
      if(state.gameModel.secret) state.gameModel.secret = false;
      else state.gameModel.secret = true;
    });
  }
}