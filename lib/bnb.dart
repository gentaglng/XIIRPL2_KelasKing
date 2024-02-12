import 'package:flutter/material.dart';
import 'package:kelas_king/bnb_absen.dart';
import 'package:kelas_king/bnb_course.dart';
import 'package:kelas_king/bnb_course_admin.dart';
import 'package:kelas_king/bnb_setting.dart';
import 'package:kelas_king/bnb_tugas.dart';
import 'package:kelas_king/model/alert.dart';

class Bnb extends StatefulWidget {
  Map data;
  Bnb({required this.data});
  @override
  State<Bnb> createState() => _BnbState();
}

class _BnbState extends State<Bnb> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final List<Widget> bodyStudent = [
      BnbCourse(
        data: widget.data,
      ),
      BnbAbsen(),
      BnbTugas(),
      BnbSetting(),
    ];
    final List<Widget> bodyTeacher = [
      BnbCourseAdmin(),
    ];
    void ontap(index) {
      setState(() {
        currentIndex = index;
      });
    }

    body() {
      if (widget.data['data'][0]['role'] == 'Student') {
        return bodyStudent[currentIndex];
      } else {
        return bodyTeacher[currentIndex];
      }
    }

    bnb(width) {
      if (widget.data['data'][0]['role'] == 'Student') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.book),
              onPressed: () => ontap(0),
              color: currentIndex == 0 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
            IconButton(
              icon: Icon(Icons.perm_contact_cal),
              onPressed: () => ontap(1),
              color: currentIndex == 1 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
            SizedBox(
              width: width / 10,
            ),
            IconButton(
              icon: Icon(Icons.assignment),
              onPressed: () => ontap(2),
              color: currentIndex == 2 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => ontap(3),
              color: currentIndex == 3 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.book),
              onPressed: () => ontap(0),
              color: currentIndex == 0 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
            SizedBox(
              width: width / 10,
            ),
            IconButton(
              icon: Icon(Icons.assignment),
              onPressed: () => ontap(2),
              color: currentIndex == 2 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
            ),
          ],
        );
      }
    }

    add() {
      if (widget.data['data'][0]['role'] == 'Student') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertStudent(
                data: widget.data,
              );
            });
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertTeacher(
                data: widget.data,
              );
            });
      }
    }

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff85CBCB),
          onPressed: () {
            add();
          },
          child: Icon(Icons.add),
        ),
        body: body(),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xffFFF5EA),
          shape: CircularNotchedRectangle(),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: width / 50),
              child: bnb(width)),
        ));
  }
}
