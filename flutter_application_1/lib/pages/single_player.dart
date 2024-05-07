import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/game_board.dart';

class SinglePlayer extends StatelessWidget {
  const SinglePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Gaming"),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Testing Game",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: const GameBoard(),
        ),
      ],
    );
  }
}

