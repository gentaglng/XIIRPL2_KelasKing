import 'package:flutter/material.dart';

class Rekap extends StatelessWidget {
  Color color;
  Rekap({required this.color});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: color,
          width: width / 3,
          height: width / 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width / 15,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: Text(
                    'TOTAL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              height: width / 4 - width / 15,
              width: width / 3,
              child: Center(
                child: Text(
                  '333',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: width / 8),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class Eror extends StatelessWidget {
  final String msg;
  var width;
  Eror({
    required this.msg,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      content: Container(
        height: width,
        width: width,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                msg,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Warning extends StatelessWidget {
  final String msg;
  var width;
  Warning({
    required this.msg,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            msg,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    ;
  }
}
