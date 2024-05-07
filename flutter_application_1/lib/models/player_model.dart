// Define a class for a Player
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/deck_model.dart';

class Player extends ChangeNotifier{
  List<CardModel> hand = []; // Hand variable to keep track of the cards in the hand
  final bool isBot; // Boolean variable to tell if the player is a bot or not
  final String name;

  Player({required this.hand, this.isBot = false, required this.name});

  // Function to add a card to the player's hand
  void addCardToHand(CardModel card) {
    hand.add(card);
    notifyListeners();
  }

  // Function to remove a card from the player's hand
  void removeCardFromHand(CardModel card) {
    hand.remove(card);
    notifyListeners();
  }

  // Function to get the number of cards in the player's hand
  int getHandSize() {
    return hand.length;
  }

  // Function to remove two cards with the same value from the hand
  void removeAllPairs() {
    while (true) {
      List<CardModel> cardsToRemove = [];
      for (int i = 0; i < hand.length - 1; i++) {
        for (int j = i + 1; j < hand.length; j++) {
          if (hand[i].value == hand[j].value) {
            cardsToRemove.add(hand[i]);
            cardsToRemove.add(hand[j]);
            break;
          }
        }
      }
      if (cardsToRemove.isEmpty) {
        break;
      }
      for (CardModel card in cardsToRemove) {
        hand.remove(card);
      }
    }
  }
}