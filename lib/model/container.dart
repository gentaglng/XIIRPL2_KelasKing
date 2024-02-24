import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemContainer extends StatelessWidget {
  var width;
  final Color color;
  final Color bg;
  final String tx;
  final String waktu;
  Function fun;
  ItemContainer({
    required this.width,
    required this.color,
    required this.bg,
    required this.tx,
    required this.waktu,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3, left: 2),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Container(
              height: width / 2.3,
              width: width / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: bg),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: width / 30, left: width / 30),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.red.withOpacity(0.2),
                  size: width / 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Container(
                  height: width / 5,
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
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tx,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                waktu,
                                style: TextStyle(color: Colors.red),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                fun();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: color),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Text(
                                    'Absen',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemContainerDone extends StatelessWidget {
  var width;
  final Color color;
  final Color bg;
  final String tx;
  final String waktu;
  final String keterangan;
  ItemContainerDone({
    required this.width,
    required this.color,
    required this.bg,
    required this.tx,
    required this.waktu,
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3, left: 2),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Container(
              height: width / 2.5,
              width: width / 2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: bg),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: width / 30, left: width / 30),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green.withOpacity(0.3),
                  size: width / 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Container(
                  height: width / 6,
                  width: width / 2.5,
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
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tx,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                keterangan,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                waktu,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
