import 'package:flutter/material.dart';

class TxtSub extends StatelessWidget {
  String txt;
  TxtSub({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    );
  }
}

class TxtSmall extends StatelessWidget {
  String txt;
  TxtSmall({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
    );
  }
}

class TxtNormal extends StatelessWidget {
  String txt;
  var weight;
  TxtNormal({
    required this.txt,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(fontSize: 18, fontWeight: weight),
    );
  }
}
