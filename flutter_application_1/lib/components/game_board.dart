import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/deck_model.dart';
import 'package:flutter_application_1/models/player_model.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  late Deck deck;

  List<Player> players = [
    Player(hand: [], isBot: true),
    Player(hand: [], isBot: true),
    Player(hand: [], isBot: true),
    Player(hand: [], isBot: true),
  ];

  @override
  void initState() {
    super.initState();
    tempFunction();
  }

  void tempFunction(){
    deck = Deck();
    deck.shuffle();

    //deal cards
    for (int i = 0; i < deck.cards.length; i++) {
      players[i % 4].addCardToHand(deck.cards[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hand(hand : players[0].hand),
          Hand(hand : players[1].hand),
          Hand(hand : players[2].hand),
          Hand(hand : players[3].hand),
        ],
      ),
    );
  }
}

class Hand extends StatelessWidget {
  final List<CardModel> hand;

  Hand({required this.hand});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: hand.map((card) => CardWidget(card: card)).toList(),
    );
  }
}

class CardWidget extends StatelessWidget {
  final CardModel card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 175,
      //margin: EdgeInsets.all(5),
      child: Image.asset(card.imagePath),
    );
  }
}