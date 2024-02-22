import 'package:flutter/material.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:intl/intl.dart';

class CourseDetail extends StatefulWidget {
  String img;
  Map data;
  CourseDetail({
    required this.data,
    required this.img,
  });

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  button(c1, c2, c3, width) {
    if (c1) {
      return Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: Container(
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
        ),
      );
    } else if (c2) {
      return Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: Container(
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
        ),
      );
    } else if (c3) {
      return Padding(
        padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: Container(
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

  String _cek = '';

  Color _absenColor = Color(0xffF9E2AE);
  Color _nilaiColor = Color(0xffF9E2AE);

  void _handleButton1Click() {
    setState(() {
      if (_cek == 'absen') {
        _cek = '';
        _absenColor = Color(0xffF9E2AE);
      } else {
        _cek = 'absen';
        _absenColor = Color(0xffFBC78D);
        _nilaiColor = Color(0xffF9E2AE);
      }
    });
  }

  void _handleButton2Click() {
    setState(() {
      if (_cek == 'nilai') {
        _cek = '';
        _nilaiColor = Color(0xffF9E2AE);
      } else {
        _cek = 'nilai';
        _nilaiColor = Color(0xffFBC78D);
        _absenColor = Color(0xffF9E2AE);
      }
    });
  }

  absenNilai(width) {
    if (_cek == 'absen') {
      return Column(
        children: [
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
        ],
      );
    } else if (_cek == 'nilai') {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffA8DEE0).withOpacity(0.3),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tuntas',
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
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tuntas',
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
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Button(
                  button: 'Rekap Nilai',
                  color: Color(0xff85CBCB),
                  shadow: Color(0xffA8DEE0),
                  fun: () {},
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget build(
    BuildContext context,
  ) {
    print(_timeString);
    print(_dateString);
    print(_dayString);
    print(widget.img);
    var width = MediaQuery.of(context).size.width;
    final List<Color> color = [
      Color(0xffDEDAF4),
      Color(0xffD9EDF8),
      Color(0xffE4F1EE)
    ];
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
            Stack(alignment: Alignment.center, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  'images/bg1' + widget.img + '.png',
                  width: width,
                  fit: BoxFit.fill,
                  height: width / 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: TxtSub(txt: widget.data['nama']),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFFF5EA),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _handleButton1Click,
                        child: Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            color: _absenColor,
                            borderRadius: BorderRadius.circular(width / 20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Absen',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleButton2Click,
                        child: Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            color: _nilaiColor,
                            borderRadius: BorderRadius.circular(width / 20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Nilai',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            absenNilai(width),
            _cek == ''
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(),
                  )
                : Container(),
            Row(
              children: [
                Expanded(child: Search()),
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff85CBCB),
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Icon(
                                Icons.tune,
                                color: Colors.white,
                              ),
                            )))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(children: [
                        Container(
                          height: width / 4,
                          decoration: BoxDecoration(
                            color: color[index % color.length],
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8)),
                          ),
                        ),
                        Container(
                          width: width,
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
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        '0' + (index + 1).toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Brzenska',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    );
                  }),
            )
          ],
        ));
  }
}
