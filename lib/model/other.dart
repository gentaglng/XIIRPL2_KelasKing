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
