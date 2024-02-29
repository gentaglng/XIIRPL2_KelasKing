import 'package:apk_kelas_king/model/button.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopUpAbsensi extends StatefulWidget {
  final Map datacourse;
  PopUpAbsensi({
    required this.datacourse,
  });

  @override
  State<PopUpAbsensi> createState() => _PopUpAbsensiState();
}

class _PopUpAbsensiState extends State<PopUpAbsensi> {
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

  @override
  Widget build(BuildContext context) {
    return PopUp(
        title: "Buat Absensi",
        form: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Judul(txt: 'Hari'),
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
                              rabu = 'Selasa';
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
                          Sabtuv = !Sabtuv;
                          setState(() {
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
                Judul(txt: 'Waktu'),
                SizedBox(
                  height: 8,
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
                  height: 10,
                ),
                Button(
                    txt: 'Buat',
                    color: Color(0xff85CBCB),
                    shadow: Color(0xffA8DEE0),
                    op: () {
                      if ((Seninv ||
                              Selasav ||
                              Rabuv ||
                              Kamisv ||
                              Jumatv ||
                              Sabtuv ||
                              Mingguv) ==
                          false) {
                        //setstate
                      } else if (_jamstart.text == '' ||
                          _menitstart.text == '' ||
                          _jamend.text == '' ||
                          _menitend.text == '') {
                        //setstate
                      } else {
                        //function
                      }
                    })
              ],
            )));
  }
}
