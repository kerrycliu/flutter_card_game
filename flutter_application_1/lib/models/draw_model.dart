import 'package:flutter/material.dart';

class DrawModel {
  final int remaining;
  final List<Card> cards;

  DrawModel({
    required this.remaining,
    this.cards = const [],
  });
}