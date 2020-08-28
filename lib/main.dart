import "package:flutter/material.dart";
import "./random_pairs.dart";

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[400],
      ),
      home: RandomWords(),
    );
  }
}
