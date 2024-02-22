import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemContainer extends StatelessWidget {
  var width;
  final Color color;
  final String tx;
  ItemContainer({
    required this.width,
    required this.color,
    required this.tx,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: width / 4,
          width: width / 1.5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Container(
            width: width / 1.5,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1,
                      offset: Offset(0, 1))
                ],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: Text(
                            'Absen',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
