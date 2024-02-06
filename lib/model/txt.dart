import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Txt extends StatelessWidget {
  final String txt;

  var weight;
  Color color;
  Txt({
    required this.txt,
    required this.weight,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(fontWeight: weight, color: color),
    );
  }
}
