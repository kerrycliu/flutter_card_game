// Define a class for a Player
import 'package:flutter_application_1/models/deck_model.dart';

class Player {
  List<CardModel> hand = []; // Hand variable to keep track of the cards in the hand
  final bool isBot; // Boolean variable to tell if the player is a bot or not

  Player({required this.hand, this.isBot = false});

  // Function to add a card to the player's hand
  void addCardToHand(CardModel card) {
    hand.add(card);
  }

  // Function to remove a card from the player's hand
  void removeCardFromHand(CardModel card) {
    hand.remove(card);
  }

  // Method to get the number of cards in the player's hand
  int getHandSize() {
    return hand.length;
  }

  // Method to get the player's hand as a string
  String getHandAsString() {
    String handString = "";
    for (CardModel card in hand) {
      handString += "${card.value} of ${card.suit}, ";
    }
    return handString.substring(0, handString.length - 2);
  }
}