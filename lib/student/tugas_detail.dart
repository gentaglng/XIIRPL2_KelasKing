import 'package:apk_kelas_king/model/button.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TugasDetail extends StatelessWidget {
  final Map datatugas;
  TugasDetail({required this.datatugas});

  TextEditingController _submitController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: Container()),
              Image.asset(
                'images/bgdown.png',
                height: height / 4,
                width: width,
                fit: BoxFit.fill,
              ),
            ],
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Judul(txt: 'Course'),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 10),
                        child: Text(datatugas['nama']),
                      ),
                      Judul(txt: 'Materi'),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 10),
                        child: Text(datatugas['judul']),
                      ),
                      Judul(txt: 'Tugas'),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 10),
                        child: Text(datatugas['tugas']),
                      ),
                      TextFormField(
                        maxLines: 5,
                        controller: _submitController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Pengumpulan tugas",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "isi pengumpulan!";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Button(
                            txt: 'Kumpulkan',
                            color: Color(0xff85CBCB),
                            shadow: Color(0xffA8DEE0),
                            op: () async {
                              if (_formKey.currentState!.validate()) {}
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
