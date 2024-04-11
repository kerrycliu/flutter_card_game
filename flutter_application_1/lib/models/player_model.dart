import 'package:flutter_application_1/models/card_model.dart';

class PlayerModel {
  final String name;
  final bool isHuman;
  List<CardModel> cards;
  
  PlayerModel({
    required this.name,
    this.cards = const [],
    this.isHuman = false,
  });
}