import 'package:apk_kelas_king/model/button.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TTugasDetail extends StatelessWidget {
  final Map datatugas;
  TTugasDetail({required this.datatugas});

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
                    Judul(txt: 'Deadline'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            datatugas['deadline'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: Text(
                          'Rekap Pengumpulan Tugas',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
