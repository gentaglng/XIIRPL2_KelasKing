import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kelas_king_apk/auth/login.dart';
import 'package:kelas_king_apk/bnb/bnb.dart';
import 'package:kelas_king_apk/model/bg.dart';
import 'package:kelas_king_apk/model/button.dart';
import 'package:kelas_king_apk/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kelas_king_apk/url.dart';
import 'package:provider/provider.dart';

class Warning extends StatelessWidget {
  final String tx;
  Warning({required this.tx});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            tx,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class Eror extends StatelessWidget {
  final String tx;
  Eror({required this.tx});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: Container(
          width: width,
          height: width / 2,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  tx,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class Wait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        content: Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Tunggu sebentar..',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Logout?'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: width / 4,
                          height: width / 10,
                          child: Center(
                            child: Text(
                              'Batal',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          width: width / 4,
                          height: width / 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: Center(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Join extends StatefulWidget {
  Map data;
  Join({
    required this.data,
  });

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _kodeController = TextEditingController();

  String warning = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //join
    Future join() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.post(Uri.parse(currentUrl + 'api/course/join'), body: {
          "user_id": widget.data['data']['id'].toString(),
          "course_id": _kodeController.text
        });
        Map dataa = json.decode(response.body);
        String message = dataa['message'];
        if (message == 'Berhasil bergabung course') {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Bnb(
                        data: widget.data,
                        state: 0,
                      )));
        } else {
          Navigator.pop(context);
          setState(() {
            warning = message;
          });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(tx: e.toString());
            });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            Bg(
                child: Padding(
              padding: EdgeInsets.all(width / 15),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gabung Course',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: width / 30, bottom: width / 20),
                        child: TxtField(
                            controller: _kodeController,
                            hint: 'Kode course',
                            icon: Icon(
                              Icons.key,
                              color: Colors.grey,
                            ),
                            validator: 'isi kode course'),
                      ),
                      warning == '' ? Container() : Warning(tx: warning),
                      Button(
                          tx: 'Gabung',
                          color: Color(0xff85CBCB),
                          shadow: Color(0xffA8DEE0),
                          fun: () async {
                            if (_formKey.currentState!.validate()) {
                              join();
                            }
                          }),
                    ]),
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(width / 30),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 13,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddCourse extends StatefulWidget {
  Map data;
  AddCourse({
    required this.data,
  });
  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  String? yesOrNO;

  List<String> items = ['Buat', 'Tidak'];

  bool value = false;

  String warning = '';

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //addcourse
    Future add() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.post(Uri.parse(currentUrl + 'api/course/add'), body: {
          "nama": _nameController.text,
          "instructor_id": widget.data['data']['id'].toString(),
          "role": widget.data['data']['role'],
          "absen": yesOrNO == 'Buat' ? 'yes' : 'no',
        });
        Map dataa = json.decode(response.body);
        String message = dataa['message'];
        if (message == 'Course berhasil dibuat') {
          Navigator.pop(context);
          yesOrNO == 'Buat'
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AddJadwal(
                      data: widget.data,
                      datacourse: dataa,
                    );
                  })
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Bnb(
                            data: widget.data,
                            state: 0,
                          )));
        } else {
          Navigator.pop(context);
          setState(() {
            warning = message;
          });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(tx: e.toString());
            });
      }
    }

    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          content: Stack(
            alignment: Alignment.topRight,
            children: [
              Bg(
                  child: Padding(
                padding: EdgeInsets.all(width / 15),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buat Course',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: width / 30, bottom: width / 50),
                          child: TxtField(
                              controller: _nameController,
                              hint: 'Nama course',
                              icon: Icon(
                                Icons.book,
                                color: Colors.grey,
                              ),
                              validator: 'isi nama course'),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: width / 30),
                              child: Icon(
                                Icons.check_circle,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'pilih absensi';
                            }
                            return null;
                          },
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
                        SizedBox(
                          height: width / 30,
                        ),
                        warning == '' ? Container() : Warning(tx: warning),
                        Button(
                            tx: 'Buat',
                            color: Color(0xff85CBCB),
                            shadow: Color(0xffA8DEE0),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                add();
                              }
                            }),
                      ],
                    )),
              )),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(width / 30),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 13,
                    child: Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class AddJadwal extends StatefulWidget {
  Map data;
  Map datacourse;
  AddJadwal({
    required this.data,
    required this.datacourse,
  });
  @override
  State<AddJadwal> createState() => _AddJadwalState();
}

class _AddJadwalState extends State<AddJadwal> {
  final _formKey = GlobalKey<FormState>();

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

  String warning = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //addabsen
    Future addjadwal() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response = await http
            .post(Uri.parse(currentUrl + 'api/course/absen/add'), body: {
          "hari": senin + selasa + rabu + kamis + jumat + sabtu + minggu,
          "mulai": _jamstart.text + ":" + _menitstart.text,
          "selesai": _jamend.text + ":" + _menitend.text,
          "course_id": widget.datacourse['data']['id'].toString(),
        });
        Map dataa = json.decode(response.body);
        String message = dataa['message'];
        if (message == 'Jadwal absen berhasil dibuat') {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Bnb(
                        data: widget.data,
                        state: 0,
                      )));
        } else {
          Navigator.pop(context);
          setState(() {
            warning = message;
          });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(tx: e.toString());
            });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          content: Bg(
              child: Padding(
            padding: EdgeInsets.all(width / 15),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buat Absensi',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: width / 30,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffF9E2AE),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          child: Text(
                            'Hari',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Senin'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Selasa'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Rabu'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Kamis'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Jumat'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Sabtu'),
                          SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            activeColor: Color(0xff85CBCB),
                            visualDensity: VisualDensity(
                              horizontal: -4,
                            ),
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
                          Text('Minggu'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width / 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffF9E2AE),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        child: Text(
                          'Waktu',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      'Contoh = 09:07 sd 16:59',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 35,
                              padding: EdgeInsets.zero,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                    SizedBox(
                      height: width / 50,
                    ),
                    warning == '' ? Container() : Warning(tx: warning),
                    Button(
                        tx: 'Buat',
                        color: Color(0xff85CBCB),
                        shadow: Color(0xffA8DEE0),
                        fun: () {
                          if ((Seninv ||
                                  Selasav ||
                                  Rabuv ||
                                  Kamisv ||
                                  Jumatv ||
                                  Sabtuv ||
                                  Mingguv) ==
                              false) {
                            setState(() {
                              warning = 'Hari harus dipilih';
                            });
                          } else if (_jamstart.text == '' ||
                              _menitstart.text == '' ||
                              _jamend.text == '' ||
                              _menitend.text == '') {
                            setState(() {
                              warning = 'Waktu harus diisi';
                            });
                          } else {
                            addjadwal();
                          }
                        }),
                  ],
                )),
          ))),
    );
  }
}

// ignore: must_be_immutable
class AbsenShow extends StatefulWidget {
  final String user_id;
  final String course_id;
  Map data;
  AbsenShow({
    required this.user_id,
    required this.course_id,
    required this.data,
  });
  @override
  State<AbsenShow> createState() => _AbsenShowState();
}

class _AbsenShowState extends State<AbsenShow> {
  String _selectedValue = '';

  void _handleRadioValueChanged(String? value) {
    setState(() {
      _selectedValue = value.toString();
    });
  }

  String waktu = '';
  String hari = '';
  String tanggal = '';
  String bulan = '';
  String tahun = '';
  @override
  void initState() {
    super.initState();
    _date();
  }

  void _date() {
    final String formattedWaktu = DateFormat('HH:mm').format(DateTime.now());
    final String formattedHari =
        DateFormat('EEEE', 'id_ID').format(DateTime.now());
    final String formattedTanggal =
        DateFormat('dd', 'id_ID').format(DateTime.now());
    final String formattedBulan =
        DateFormat('MMMM', 'id_ID').format(DateTime.now());
    final String formattedTahun =
        DateFormat('yyyy', 'id_ID').format(DateTime.now());

    setState(() {
      waktu = formattedWaktu;
      hari = formattedHari;
      tanggal = formattedTanggal;
      bulan = formattedBulan;
      tahun = formattedTahun;
    });
  }

  String warning = '';

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //absen
    Future absen(String keterangan) async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.post(Uri.parse(currentUrl + 'api/course/absen'), body: {
          "course_id": widget.course_id,
          "user_id": widget.user_id,
          "keterangan": keterangan,
          "hari": hari,
          "tanggal": tanggal,
          "bulan": bulan,
          "tahun": tahun,
          "waktu": waktu
        });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Absen berhasil') {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Bnb(data: widget.data, state: 1)));
        } else {
          Navigator.pop(context);
          setState(() {
            warning = message;
          });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(tx: e.toString());
            });
      }
    }

    String date = hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun;
    var width = MediaQuery.of(context).size.width;
    pilihabsen() {
      if (_selectedValue == 'Masuk') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absen('Masuk');
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (_selectedValue == 'Izin') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child: Container(
                      height: width / 1.5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo,
                            size: width / 6,
                            color: Colors.grey,
                          ),
                          Text(
                            'Foto Surat Izin',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absen('Izin');
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (_selectedValue == 'Sakit') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child: Container(
                      height: width / 1.5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo,
                            size: width / 6,
                            color: Colors.grey,
                          ),
                          Text(
                            'Foto Surat Sakit',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absen('Sakit');
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Warning(tx: 'Pilih absensi');
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            Bg(
              child: Padding(
                padding: EdgeInsets.only(
                    top: width / 15,
                    left: width / 15,
                    right: width / 15,
                    bottom: (width / 15) - 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Absensi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: width / 30, bottom: width / 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Radio(
                                value: 'Masuk',
                                activeColor: Color(0xff85CBCB),
                                groupValue: _selectedValue,
                                onChanged: _handleRadioValueChanged,
                                visualDensity: VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                              ),
                              Text(
                                'Masuk',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Radio(
                                value: 'Izin',
                                activeColor: Color(0xff85CBCB),
                                groupValue: _selectedValue,
                                onChanged: _handleRadioValueChanged,
                                visualDensity: VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                              ),
                              Text(
                                'Izin',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Radio(
                                value: 'Sakit',
                                activeColor: Color(0xff85CBCB),
                                groupValue: _selectedValue,
                                onChanged: _handleRadioValueChanged,
                                visualDensity: VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                              ),
                              Text(
                                'Sakit',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    warning == '' ? Container() : Warning(tx: warning),
                    pilihabsen(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(width / 30),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 13,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailSudahAbsen extends StatelessWidget {
  const DetailSudahAbsen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('data')],
      )),
    );
  }
}
