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
    Player(
      hand: [],
      isBot: true,
      name: "Bot1",
    ),
    Player(
      hand: [],
      isBot: true,
      name: "Bot2",
    ),
    Player(
      hand: [],
      isBot: true,
      name: "Bot3",
    ),
    Player(
      hand: [],
      isBot: true,
      name: "Bot4",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    deck = Deck();
    deck.shuffle();
    _dealCards();
    _removePairsFromHands();
  }

  void _dealCards() {
    for (int i = 0; i < deck.cards.length; i++) {
      players[i % 4].addCardToHand(deck.cards[i]);
    }
  }

  void _removePairsFromHands() {
    for (int i = 0; i < players.length; i++) {
      players[i].removeAllPairs();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (players[0].hand.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Stack(
      children: [
        Container(
          color: const Color.fromRGBO(184, 170, 255, 100),
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(//bottom
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(players[2].hand.length, (int index) {
                    return Draggable_Card(card: players[2].hand[index]);
                  }),
                ),
          
                Row(//sides
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(players[1].hand.length, (int index) {
                        return Draggable_CardH(card: players[1].hand[index]);
                      }),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(players[3].hand.length, (int index) {
                        return Draggable_CardH(card: players[3].hand[index]);
                      }),
                    ),
                  ],
                ),
          
                Row(//top
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(players[0].hand.length, (int index) {
                    return Draggable_Card(card: players[0].hand[index]);
                  }),
                ),
              ],
            ),
          ),
        ),

        //Draggable_Card(card: players[0].hand[0],),
      ],
    );
  }
}

class Draggable_Card extends StatelessWidget {
  const Draggable_Card({
    super.key,
    required this.card,
  });

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Transform.translate(
        offset: const Offset(0, 0),
        child: CardContainer(card: card),
      ),
      childWhenDragging: Container(),
      child: CardContainer(card: card),
    );
  }
}

class Draggable_CardH extends StatelessWidget {
  const Draggable_CardH({
    super.key,
    required this.card,
  });

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Transform.translate(
        offset: const Offset(0, 0),
        child: CardContainerH(card: card),
      ),
      childWhenDragging: Container(),
      child: CardContainerH(card: card),
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.card,
  });

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55/1.25,
      height: 75/1.25,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.6),
        image: DecorationImage(
          image: AssetImage(card.imagePath),
          fit: BoxFit.fill,
          )
      ),
    );
  }
}

class CardContainerH extends StatelessWidget {
  const CardContainerH({
    super.key,
    required this.card,
  });

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        width: 55/1.25,
        height: 75/1.25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.6),
          image: DecorationImage(
            image: AssetImage(card.imagePath),
            fit: BoxFit.fill,
            )
        ),
      ),
    );
  }
}