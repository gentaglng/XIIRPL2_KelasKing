import 'dart:convert';

import 'package:apk_kelas_king/model/button.dart';
import 'package:apk_kelas_king/model/container.dart';
import 'package:apk_kelas_king/model/null.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/model/txtfield.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TCourseDetail extends StatefulWidget {
  final Map datacourse;
  Color color;
  TCourseDetail({
    required this.datacourse,
    required this.color,
  });

  @override
  State<TCourseDetail> createState() => _TCourseDetailState();
}

class _TCourseDetailState extends State<TCourseDetail> {
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

    //future
    Future getCourseMember() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/course/member/' +
              widget.datacourse['course_id'].toString()),
        );
        return json.decode(response.body);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return Eror(txt: e.toString());
            });
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: widget.color.withOpacity(0.7),
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          BgDetilCourse(nama: widget.datacourse['nama'], color: widget.color),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
            child: Judul(txt: 'Detail Course'),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.school,
                          size: 15,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengajar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.datacourse['namaguru'])
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.key,
                          size: 15,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kode course',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.datacourse['course_id'].toString())
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.people,
                          size: 15,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PopUp(
                                  title: "Anggota",
                                  form: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: FutureBuilder(
                                          future: getCourseMember(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return snapshot.data['message'] ==
                                                      "Berhasil mendapatkan data"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: snapshot
                                                              .data['data']
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 6),
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                      radius:
                                                                          12,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .people,
                                                                        size:
                                                                            15,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 6,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          snapshot.data['data'][index]
                                                                              [
                                                                              'nama'],
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(snapshot.data['data'][index]
                                                                            [
                                                                            'email'])
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  : DataNull(
                                                      txt: snapshot
                                                          .data["message"]);
                                            } else {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: Color(0xff85CBCB),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          })));
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff85CBCB),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Text(
                            'Anggota Course',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        child: Icon(
                          Icons.check_circle,
                          size: 15,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    widget.datacourse['absen'] == 'no'
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
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
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Senin'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Selasa'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Rabu'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Kamis'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Jumat'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
                                                      ),
                                                      Text('Sabtu'),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Checkbox(
                                                        activeColor:
                                                            Color(0xff85CBCB),
                                                        visualDensity:
                                                            VisualDensity(
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
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.3),
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
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 35,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            controller:
                                                                _jamstart,
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorColor:
                                                                Colors.black,
                                                            maxLength: 2,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: '01',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              counterText: '',
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ':',
                                                          style: TextStyle(
                                                              fontSize: 30),
                                                        ),
                                                        Container(
                                                          width: 35,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            controller:
                                                                _menitstart,
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorColor:
                                                                Colors.black,
                                                            maxLength: 2,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: '00',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
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
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            controller: _jamend,
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorColor:
                                                                Colors.black,
                                                            maxLength: 2,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: '01',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              counterText: '',
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ':',
                                                          style: TextStyle(
                                                              fontSize: 30),
                                                        ),
                                                        Container(
                                                          width: 35,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            controller:
                                                                _menitend,
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                            textAlign: TextAlign
                                                                .center,
                                                            cursorColor:
                                                                Colors.black,
                                                            maxLength: 2,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: '00',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              counterText: '',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                warning == ""
                                                    ? Container()
                                                    : Text(
                                                        warning,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                        setState(() {
                                                          warning =
                                                              'pilih hari!';
                                                        });
                                                      } else if (_jamstart
                                                                  .text ==
                                                              '' ||
                                                          _menitstart.text ==
                                                              '' ||
                                                          _jamend.text == '' ||
                                                          _menitend.text ==
                                                              '') {
                                                        setState(() {
                                                          warning =
                                                              'isi waktu!';
                                                        });
                                                      } else {
                                                        //function
                                                      }
                                                    })
                                              ],
                                            )));
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff85CBCB),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: Text(
                                  'Buat Absensi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Color(0xff85CBCB),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Text(
                                'Detail Absensi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                  ],
                )
              ]))
        ],
      ),
    );
  }
}
