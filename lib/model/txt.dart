import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Txt extends StatelessWidget {
  final String txt;
  var size;
  var weight;
  var left;
  Txt({
    required this.txt,
    required this.left,
    required this.size,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: Text(
        txt,
        style: TextStyle(fontSize: size, fontWeight: weight),
      ),
    );
  }
}
