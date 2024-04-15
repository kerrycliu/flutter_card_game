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
    for(int i = 0; i < deck.cards.length; i++){
      players[i % 4].addCardToHand(deck.cards[i]);
    }

    //remove pairs from hand
    for(int i = 0; i < players.length; i++ ){
      players[i].removeAllPairs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Hand(hand : players[0].hand),
        Hand(hand : players[1].hand),
        Hand(hand : players[2].hand),
        Hand(hand : players[3].hand),
      ],
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
      width: 55,
      height: 210,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width : 0.6),
      ),
      child: Image.asset(card.imagePath),
    );
  }
}