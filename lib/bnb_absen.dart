import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelas_king/model/txt.dart';

class BnbAbsen extends StatefulWidget {
  @override
  State<BnbAbsen> createState() => _BnbAbsenState();
}

class _BnbAbsenState extends State<BnbAbsen> {
  String _timeString = '';

  String _dateString = '';

  String _dayString = '';

  @override
  void initState() {
    super.initState();
    _getTimeString();
    _getDateString();
    _getDayString();
  }

  void _getTimeString() {
    final String formattedDateTime =
        DateFormat('HH:mm:ss').format(DateTime.now());
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  void _getDateString() {
    final String formattedDate =
        DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());
    setState(() {
      _dateString = formattedDate;
    });
  }

  void _getDayString() {
    final String formattedDay =
        DateFormat('EEEE', 'id_ID').format(DateTime.now());
    setState(() {
      _dayString = formattedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: TxtSub(txt: 'Absensi'),
        actions: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('images/night.png'),
              Column(
                children: [
                  Text(
                    _timeString,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 30),
                  ),
                  Text(
                    _dayString + ', ' + _dateString,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: width / 10,
                  )
                ],
              ),
            ],
          ),
          Container(
            color: Color(0xffA8DEE0).withOpacity(0.3),
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: 10),
              child: Column(
                children: [
                  TxtSub(txt: 'February'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hadir',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(' 100%')
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: width / 30,
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                height: width / 30,
                                width: width / 8,
                                decoration: BoxDecoration(
                                  color: Color(0xff77DD76),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sakit',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(' 100%')
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: width / 30,
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                height: width / 30,
                                width: width / 8,
                                decoration: BoxDecoration(
                                  color: Color(0xff77DD76),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Izin',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(' 100%')
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: width / 30,
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                height: width / 30,
                                width: width / 8,
                                decoration: BoxDecoration(
                                  color: Color(0xff77DD76),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Alpha',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(' 100%')
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: width / 30,
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                height: width / 30,
                                width: width / 8,
                                decoration: BoxDecoration(
                                  color: Color(0xff77DD76),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Judul(txt: 'Belum Absen'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Container(
                            height: width / 4,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              color: Color(0xffFF6962),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
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
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenska',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.red),
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
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 10),
            child: Row(
              children: [
                Judul(txt: 'Sudah Absen'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Container(
                            height: width / 4,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              color: Color(0xff77DD76),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
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
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenska',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.green),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            child: Text(
                                              'Detail',
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
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
