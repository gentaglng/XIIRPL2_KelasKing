import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kelas_king/url.dart';
import 'package:provider/provider.dart';

class AlertStudent extends StatefulWidget {
  Map data;
  AlertStudent({required this.data});

  @override
  State<AlertStudent> createState() => _AlertStudentState();
}

class _AlertStudentState extends State<AlertStudent> {
  String message = '';
  TextEditingController _codeCourse = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    Future join() async {
      var response =
          await http.post(Uri.parse(currentUrl + 'api/course/join'), body: {
        "user_id": widget.data['data'][0]['id'].toString(),
        "course_id": _codeCourse.text
      });
      print(currentUrl);
      Map dataa = json.decode(response.body);
      setState(() {
        message = dataa['message'];
      });
    }

    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtSub(txt: 'Join Course'),
              message == ''
                  ? Container()
                  : Text(
                      message,
                      style: TextStyle(color: Colors.red),
                    ),
              Padding(
                padding: EdgeInsets.only(top: width / 30, bottom: width / 20),
                child: TxtField(
                    validator: 'isi kode course',
                    controller: _codeCourse,
                    hint: 'Kode ourse',
                    icon: Icon(Icons.key)),
              ),
              Button(
                  button: 'Bergabung',
                  color: Color(0xff85CBCB),
                  shadow: Color(0xffA8DEE0),
                  fun: () async {
                    join();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertTeacher extends StatefulWidget {
  Map data;
  AlertTeacher({required this.data});
  @override
  State<AlertTeacher> createState() => _AlertTeacherState();
}

class _AlertTeacherState extends State<AlertTeacher> {
  TextEditingController _namaCourse = TextEditingController();
  String message = '';
  bool value = false;

  String? yesOrNO;

  List<String> items = ['Buat', 'Tidak'];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    Future add() async {
      var response =
          await http.post(Uri.parse(currentUrl + 'api/course/add'), body: {
        "nama": _namaCourse.text,
        "instructor_id": widget.data['data'][0]['id'].toString(),
        "role": widget.data['data'][0]['role'],
        "absen": yesOrNO == 'Buat' ? 'yes' : 'no'
      });
      Map dataa = json.decode(response.body);

      if (dataa["message"] == 'Add course success') {
        if (dataa['absen'] == 'yes') {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertAbsen();
              });
        } else if (dataa["message"] == 'Course sudah ada') {
          setState(() {
            message = dataa['message'];
          });
        }
      }
    }

    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtSub(txt: 'Create Course'),
              message == ''
                  ? Container()
                  : Text(
                      message,
                      style: TextStyle(color: Colors.red),
                    ),
              Padding(
                padding: EdgeInsets.only(top: width / 30, bottom: width / 50),
                child: TxtField(
                    validator: 'isi nama course',
                    controller: _namaCourse,
                    hint: 'Nama course',
                    icon: Icon(Icons.book)),
              ),
              Padding(
                padding: EdgeInsets.only(top: width / 50, bottom: width / 20),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: width / 30),
                      child: Icon(
                        Icons.perm_contact_cal,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    hintText: 'Buat absensi',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  value: yesOrNO,
                  items: items
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      yesOrNO = newValue as String?;
                      value = (yesOrNO != null);
                    });
                  },
                ),
              ),
              Button(
                button: 'Create Course',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () async {
                  add();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertAbsen extends StatefulWidget {
  @override
  State<AlertAbsen> createState() => _AlertAbsenState();
}

class _AlertAbsenState extends State<AlertAbsen> {
  TextEditingController _jamstart = TextEditingController();

  TextEditingController _menitstart = TextEditingController();

  TextEditingController _jamend = TextEditingController();

  TextEditingController _menitend = TextEditingController();

  bool Seninv = false;
  bool Selasav = false;
  bool Rabuv = false;
  bool Kamisv = false;
  bool Jumatv = false;
  bool Sabtuv = false;
  bool Mingguv = false;
  String senin = '';
  String selasa = '';
  String rabu = '';
  String kamis = '';
  String jumat = '';
  String sabtu = '';
  String minggu = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    Future addjadwal() async {
      var response =
          await http.post(Uri.parse(currentUrl + 'api/jadwalabsen/add'), body: {
        "hari": senin + selasa + rabu + kamis + jumat + sabtu + minggu,
        "mulai": _jamstart.text + ":" + _menitstart.text,
        "selesai": _jamend.text + ":" + _menitend.text,
        "course_id": "1"
      });
      Map data = json.decode(response.body);
      print(data);
    }

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtSub(txt: 'Jadwal Absensi'),
              Row(
                children: [
                  Text(
                    'Hari : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Seninv,
                      onChanged: (v) {
                        setState(() {
                          Seninv = !Seninv;
                          if (Seninv) {
                            senin = 'Senin';
                          } else {
                            senin = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Senin'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Selasav,
                      onChanged: (v) {
                        setState(() {
                          Selasav = !Selasav;
                          if (Selasav) {
                            selasa = 'Selasa';
                          } else {
                            selasa = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Selasa'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Rabuv,
                      onChanged: (v) {
                        setState(() {
                          Rabuv = !Rabuv;
                          if (Rabuv) {
                            rabu = 'Rabu';
                          } else {
                            rabu = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Rabu'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Kamisv,
                      onChanged: (v) {
                        setState(() {
                          Kamisv = !Kamisv;
                          if (Kamisv) {
                            kamis = 'Kamis';
                          } else {
                            kamis = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Kamis'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Jumatv,
                      onChanged: (v) {
                        setState(() {
                          Jumatv = !Jumatv;
                          if (Jumatv) {
                            jumat = 'Jumat';
                          } else {
                            jumat = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Jumat'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Sabtuv,
                      onChanged: (v) {
                        setState(() {
                          Sabtuv = !Sabtuv;
                          if (Sabtuv) {
                            sabtu = 'Sabtu';
                          } else {
                            sabtu = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Sabtu'),
                    SizedBox(
                      width: 5,
                    ),
                    Checkbox(
                      visualDensity: VisualDensity(horizontal: -4),
                      activeColor: Color(0xff85CBCB),
                      value: Mingguv,
                      onChanged: (v) {
                        setState(() {
                          Mingguv = !Mingguv;
                          if (Mingguv) {
                            minggu = 'Minggu';
                          } else {
                            minggu = '';
                          }
                        });
                      },
                      side: BorderSide(color: Colors.grey, width: 1.3),
                    ),
                    TxtSmall(txt: 'Minggu'),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Jam : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 35,
                          padding: EdgeInsets.zero,
                          child: TextField(
                            controller: _jamstart,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.black,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: '01',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 30),
                        ),
                        Container(
                          width: 35,
                          padding: EdgeInsets.zero,
                          child: TextField(
                            controller: _menitstart,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.black,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: '00',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text('sd'),
                    Row(
                      children: [
                        Container(
                          width: 35,
                          padding: EdgeInsets.zero,
                          child: TextField(
                            controller: _jamend,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.black,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: '01',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 30),
                        ),
                        Container(
                          width: 35,
                          padding: EdgeInsets.zero,
                          child: TextField(
                            controller: _menitend,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.black,
                            maxLength: 2,
                            decoration: InputDecoration(
                              hintText: '00',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Button(
                button: 'Oke',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () {
                  addjadwal();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
