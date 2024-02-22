import 'package:flutter/material.dart';
import 'package:kelas_king_apk/bnb/setting.dart';
import 'package:kelas_king_apk/bnb/user/absen.dart';
import 'package:kelas_king_apk/bnb/user/course.dart';
import 'package:kelas_king_apk/bnb/user/tugas.dart';
import 'package:kelas_king_apk/bnb/admin/absen.dart';
import 'package:kelas_king_apk/bnb/admin/course.dart';
import 'package:kelas_king_apk/bnb/admin/tugas.dart';
import 'package:kelas_king_apk/model/show.dart';

// ignore: must_be_immutable
class Bnb extends StatefulWidget {
  Map data;
  int state;
  Bnb({
    required this.data,
    required this.state,
  });

  @override
  State<Bnb> createState() => _BnbState();
}

class _BnbState extends State<Bnb> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bodyPelajar = [
      UserCourse(
        data: widget.data,
      ),
      UserAbsen(
        data: widget.data,
      ),
      UserTugas(),
      Setting(),
    ];

    final List<Widget> bodyPengajar = [
      AdminCourse(
        data: widget.data,
      ),
      AdminAbsen(),
      AdminTugas(),
      Setting(),
    ];

    void ontap(index) {
      setState(() {
        currentIndex = index;
      });
    }

    body() {
      if (widget.data['data']['role'] == 'Pelajar') {
        return bodyPelajar[currentIndex];
      } else {
        return bodyPengajar[currentIndex];
      }
    }

    bnb(width) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () => ontap(0),
            color: currentIndex == 0 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
          ),
          IconButton(
            icon: Icon(Icons.check_circle),
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
    }

    add() {
      if (widget.data['data']['role'] == 'Pelajar') {
        return showDialog(
            context: context,
            builder: (context) {
              return Join(data: widget.data);
            });
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AddCourse(
                data: widget.data,
              );
            });
      }
    }

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
