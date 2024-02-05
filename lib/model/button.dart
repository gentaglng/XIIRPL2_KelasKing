import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String button;
  Button({required this.button});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Ink(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 20),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff61F4DE), Color(0xff6E78FF)])),
      child: InkWell(
        borderRadius: BorderRadius.circular(width / 20),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(width / 20),
          child: Text(
            button,
            style: TextStyle(color: Colors.white, fontSize: width / 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
