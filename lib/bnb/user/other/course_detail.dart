import 'package:flutter/material.dart';
import 'package:kelas_king_apk/bnb/bnb.dart';
import 'package:kelas_king_apk/model/other.dart';
import 'package:kelas_king_apk/model/show.dart';

// ignore: must_be_immutable
class CourseDetailUser extends StatelessWidget {
  Map datacourse;
  Map data;
  CourseDetailUser({
    required this.datacourse,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          'Detail Course',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LogOut();
                  });
            },
            child: CircleAvatar(
              child: data['data']['role'] == 'Pelajar'
                  ? Icon(Icons.people)
                  : Icon(Icons.school),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        children: [
          Judul(tx: 'Absensi'),
          datacourse['absen'] == 'yes'
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text('Absensi tersedia untuk course ini'),
                      SizedBox(
                        height: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Bnb(data: data, state: 1)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff85CBCB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Absensi?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Absensi tidak tersedia untuk course ini',
                    textAlign: TextAlign.center,
                  ),
                )
        ],
      ),
    );
  }
}
