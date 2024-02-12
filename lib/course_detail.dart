import 'package:flutter/material.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:intl/intl.dart';

class CourseDetail extends StatefulWidget {
  Map data;
  CourseDetail({required this.data});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  button(c1, c2, c3, width) {
    if (c1) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffA8DEE0).withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TxtSmall(txt: '19.90'),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TxtSmall(txt: 'Purwokerto selatan'),
              ),
              Button(
                button: 'Submit',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () {},
              ),
            ],
          ),
        ),
      );
    } else if (c2) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffA8DEE0).withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TxtSmall(txt: '19.90'),
              TxtSmall(txt: 'Purwokerto selatan'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Container(
                    width: width,
                    height: width,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.05)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Upload Surat Izin',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
              Button(
                button: 'Submit',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () {},
              ),
            ],
          ),
        ),
      );
    } else if (c3) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffA8DEE0).withOpacity(0.3),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TxtSmall(txt: '19.90'),
              TxtSmall(txt: 'Purwokerto selatan'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Container(
                    width: width,
                    height: width,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.05)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Upload Surat Sakit',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
              Button(
                button: 'Submit',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () {},
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

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

  Widget build(BuildContext context) {
    print(_timeString);
    print(_dateString);
    print(_dayString);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          actions: [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView(
          children: [
            TxtSub(txt: widget.data['nama']),
            Row(
              children: [
                Judul(txt: 'Absen'),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.verified),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: checkbox1,
                      onChanged: (v) {
                        setState(() {
                          checkbox1 = v!;
                          if (v!) {
                            checkbox2 = false;
                            checkbox3 = false;
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Hadir'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: checkbox2,
                      onChanged: (v) {
                        setState(() {
                          checkbox2 = v!;
                          if (v!) {
                            checkbox1 = false;
                            checkbox3 = false;
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Izin'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: checkbox3,
                      onChanged: (v) {
                        setState(() {
                          checkbox3 = v!;
                          if (v!) {
                            checkbox1 = false;
                            checkbox2 = false;
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Sakit'),
                  ],
                ),
              ],
            ),
            button(checkbox1, checkbox2, checkbox3, width / 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Judul(txt: 'Nilai'),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff85CBCB),
                        borderRadius: BorderRadius.circular(8)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Text(
                              'Rekap Nilai',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              'Nilai Tak',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Stack(children: [
                  Container(
                      height: width / 30,
                      width: width / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8))),
                  Container(
                      height: width / 30,
                      width: width / 4,
                      decoration: BoxDecoration(
                          color: Color(0xff77DD76),
                          borderRadius: BorderRadius.circular(8))),
                ]),
                Text('100%')
              ],
            ),
            Text(
              'Nilai Tak Tuntas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Stack(children: [
                  Container(
                      height: width / 30,
                      width: width / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8))),
                  Container(
                      height: width / 30,
                      width: width / 3,
                      decoration: BoxDecoration(
                          color: Color(0xffFF6962),
                          borderRadius: BorderRadius.circular(8))),
                ]),
                Text('100%')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Judul(txt: 'Materi & Tugas'),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff85CBCB),
                        borderRadius: BorderRadius.circular(8)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Search()
          ],
        ));
  }
}
