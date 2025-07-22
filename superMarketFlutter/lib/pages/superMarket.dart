import 'package:flutter/material.dart';

class Supermarket extends StatefulWidget {
  const Supermarket({super.key});

  @override
  State<Supermarket> createState() => _SupermarketState();
}

class _SupermarketState extends State<Supermarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Market"),
      ),
    );
  }
}
