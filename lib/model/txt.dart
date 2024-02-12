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

class Judul extends StatelessWidget {
  final String txt;
  Judul({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9E2AE),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: TxtNormal(
          txt: txt,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
