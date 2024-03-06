import 'dart:convert';

import 'package:apk_kelas_king/bnb.dart';
import 'package:apk_kelas_king/model/container.dart';
import 'package:apk_kelas_king/model/null.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/model/show/absensi.dart';
import 'package:apk_kelas_king/model/show/anggota.dart';
import 'package:apk_kelas_king/model/txtfield.dart';
import 'package:apk_kelas_king/teacher/materi_detail.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/button.dart';
import '../model/other.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class TCourseDetail extends StatefulWidget {
  final Map datacourse;
  final Map datauser;
  Color color;
  TCourseDetail({
    required this.datacourse,
    required this.datauser,
    required this.color,
  });

  @override
  State<TCourseDetail> createState() => _TCourseDetailState();
}

final List<Color> colorr = [
  Color(0xffDEDAF4),
  Color(0xffD9EDF8),
  Color(0xffE4F1EE),
];
popup(String popup, context, datacourse, datauser) {
  if (popup == "Anggota") {
    showDialog(
        context: context,
        builder: (context) {
          return PopUpAnggota(datacourse: datacourse);
        });
  } else if (popup == "Absensi") {
    showDialog(
        context: context,
        builder: (context) {
          return PopUpAbsensi(datacourse: datacourse, datauser: datauser);
        });
  }
}

class _TCourseDetailState extends State<TCourseDetail> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //future
    Future getMateri() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/materi/' +
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
            child: Column(
              children: [
                DetailItem(
                  judul: "Pengajar",
                  data: widget.datacourse['namaguru'],
                  icon: Icon(
                    Icons.school,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: DetailItem(
                    judul: "Kode Course",
                    data: widget.datacourse['course_id'].toString(),
                    icon: Icon(
                      Icons.key,
                      size: 15,
                    ),
                  ),
                ),
                DetailItem(
                  icon: Icon(
                    Icons.people,
                    size: 15,
                  ),
                  judul: "Anggota Course",
                  op: () {
                    popup(
                        "Anggota", context, widget.datacourse, widget.datauser);
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 10),
                    child: widget.datacourse['absen'] == 'no'
                        ? DetailItem(
                            icon: Icon(
                              Icons.check_circle,
                              size: 15,
                            ),
                            judul: "Buat Absensi",
                            op: () {
                              popup("Absensi", context, widget.datacourse,
                                  widget.datauser);
                            },
                          )
                        : DetailItem(
                            icon: Icon(
                              Icons.check_circle,
                              size: 15,
                            ),
                            judul: "Detail absensi",
                            op: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Bnb(
                                          datauser: widget.datauser, idx: 1)));
                            },
                          )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Judul(txt: 'Materi'),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: (context),
                        builder: (context) {
                          final _formKey = GlobalKey<FormState>();
                          TextEditingController _judulController =
                              TextEditingController();
                          TextEditingController _descController =
                              TextEditingController();
                          TextEditingController _tautanController =
                              TextEditingController();
                          TextEditingController _fotoController =
                              TextEditingController();
                          Future addMateri() async {
                            try {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Wait();
                                  });
                              var response = await http.post(
                                  Uri.parse(currentUrl + 'api/materi/add'),
                                  body: {
                                    "course_id": widget.datacourse['course_id']
                                        .toString(),
                                    "judul": _judulController.text,
                                    "deskripsi": _descController.text,
                                    "tautan": _tautanController.text == ""
                                        ? "no"
                                        : _tautanController.text,
                                    "foto": _fotoController.text == ""
                                        ? "no"
                                        : _fotoController.text,
                                  });
                              Map data = json.decode(response.body);
                              String message = data['message'];
                              if (message == 'Berhasil menambahkan materi') {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Eror(txt: message);
                                    });
                              }
                            } catch (e) {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Eror(txt: e.toString());
                                  });
                            }
                          }

                          return PopUp(
                              title: "Buat Materi",
                              form: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TxtField(
                                        controller: _judulController,
                                        hint: "Judul",
                                        icon: Icon(Icons.book,
                                            color: Colors.grey),
                                        validator: "isi judul!"),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        maxLines: 3,
                                        controller: _descController,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                            prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                    right: width / 30,
                                                    bottom: 38),
                                                child: Icon(Icons.description,
                                                    color: Colors.grey)),
                                            prefixIconConstraints:
                                                BoxConstraints(
                                              minWidth: 0,
                                              minHeight: 0,
                                            ),
                                            hintText: "Deskripsi",
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "isi deskripsi!";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    TxtField(
                                      controller: _tautanController,
                                      hint: "Link (opsional)",
                                      icon:
                                          Icon(Icons.link, color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xff85CBCB),
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Foto (opsional)',
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Button(
                                        txt: 'Buat',
                                        color: Color(0xff85CBCB),
                                        shadow: Color(0xffA8DEE0),
                                        op: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            addMateri();
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ));
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff85CBCB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Text(
                        'Buat Materi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                  future: getMateri(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data['message'] ==
                              "Belum ada materi di course ini"
                          ? DataNull(txt: snapshot.data["message"])
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TMateriDetail(
                                                    datauser: widget.datauser,
                                                    datamateri: snapshot
                                                        .data['data'][index],
                                                  )));
                                    },
                                    child: Column(children: [
                                      Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: colorr[index % colorr.length],
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(8)),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'images/top.png',
                                              fit: BoxFit.fill,
                                              width: width,
                                            ),
                                            Icon(
                                              Icons.book,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                            ),
                                            Image.asset(
                                              'images/topp.png',
                                              fit: BoxFit.fill,
                                              width: width,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(
                                                      index < 9
                                                          ? '0' +
                                                              (index + 1)
                                                                  .toString()
                                                          : (index + 1)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.9)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data['data']
                                                          [index]['judul'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      snapshot.data['data']
                                                          [index]['deskripsi'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.assignment,
                                                size: width / 20,
                                                color: snapshot.data['data']
                                                            [index]['tugas'] ==
                                                        'no'
                                                    ? Colors.grey
                                                    : Colors.blue,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                );
                              });
                    } else {
                      return Text('Loading');
                    }
                  })),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailItem extends StatelessWidget {
  final String? judul;
  final Function()? op;
  final String? data;
  final Icon? icon;

  DetailItem({
    this.judul,
    this.data,
    this.icon,
    this.op,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 12, child: icon),
        SizedBox(
          width: 6,
        ),
        op == null
            ? Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data ?? ''),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  op!();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff85CBCB),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      judul ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
