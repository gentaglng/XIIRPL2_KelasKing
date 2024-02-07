import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String button;
  Color color;
  Color shadow;
  Function nav;
  Button({
    required this.button,
    required this.color,
    required this.shadow,
    required this.nav,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 20),
          color: color,
          boxShadow: [
            BoxShadow(
                color: shadow.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(width / 20),
          onTap: () {
            nav();
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              button,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
