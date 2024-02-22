import 'package:flutter/material.dart';

class Bg extends StatelessWidget {
  final Widget child;
  Bg({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(0, 3))
          ]),
      child: child,
    );
  }
}
