import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/deck_model.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Deck deck;

  @override
  void initState() {
    super.initState();
    deck = Deck();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var card in deck.cards)
          Column(
            children: [
              SizedBox(
                height: 275,
                width: 50,
                child : Card(
                  child: Image.asset(card.imagePath),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}