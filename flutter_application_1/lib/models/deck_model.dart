// Define a class for a single card
class CardModel {
  final String imagePath; // Image path for the card
  final String backPath; //image path for the card back
  final String suit;
  final String value;

  CardModel({required this.imagePath, this.backPath = 'images/Cards/Card_Back.png' , required this.suit, required this.value});
}

// Define a class for the deck of cards
class Deck {
  List<CardModel> cards = [];

  Deck() {
    // Initialize the deck with all 52 cards
    List<String> suits = ['Heart', 'Diamond', 'Clubs', 'Spades'];
    List<String> values = [
      '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'
    ];

    for (var suit in suits) {
      for (var value in values) {
        String imagePath = 'images/Cards/$suit/Rank=$value, Suit=$suit.png';
        cards.add(CardModel(imagePath: imagePath, suit: suit, value: value));
      }
    }
    
    //add a joker to the deck
    cards.add(CardModel(imagePath: "images/Cards/Joker.png", suit: 'Joker', value: 'Joker'));
  }
}

// Example usage:
void main() {
  Deck deck = Deck();
  print(deck.cards[0].imagePath); // Example accessing the image path of the first card in the deck
}
