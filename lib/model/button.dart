import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String button;
  Color color;
  Color shadow;
  Function fun;
  Button({
    required this.button,
    required this.color,
    required this.shadow,
    required this.fun,
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
            fun();
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

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      visualDensity: VisualDensity(horizontal: -4),
      activeColor: Color(0xff85CBCB),
      value: value,
      onChanged: (v) {
        setState(() {
          value = !value;
        });
      },
      side: BorderSide(color: Colors.grey, width: 1.3),
    );
  }
}
