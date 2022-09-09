import 'dart:math';

class FlutterGame {
  bool secret = true;
  int location = 0;
  int balance = 8;
  int debt = 0;
  int mode = 0; //0 is Betting Mode, 1 is Result Mode.
  List<int> key = [0,0,0]; //Flutter is where 1 is.
  List<int> bets = [0,0,0];

  void generateKey() {
    Random rng = Random();
    int x = rng.nextInt(3);
    key[x] = 1;
    location = x;
  }

  void checkBets() {
    if(bets[location] != 0) {
      balance += bets[location] * 3;
    }
  }
}