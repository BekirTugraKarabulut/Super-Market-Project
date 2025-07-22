import 'package:flutter/material.dart';

class Supermanav extends StatefulWidget {
  const Supermanav({super.key});

  @override
  State<Supermanav> createState() => _SupermanavState();
}

class _SupermanavState extends State<Supermanav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Manav"),
      ),
    );
  }
}
