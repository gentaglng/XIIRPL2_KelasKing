import 'package:flutter/material.dart';
import 'package:kelas_king/bnb_absen.dart';
import 'package:kelas_king/bnb_course.dart';
import 'package:kelas_king/bnb_setting.dart';
import 'package:kelas_king/bnb_tugas.dart';

class Bnb extends StatefulWidget {
  @override
  State<Bnb> createState() => _BnbState();
}

class _BnbState extends State<Bnb> {
  int currentIndex = 0;
  final List<Widget> body = [
    BnbCourse(),
    BnbAbsen(),
    BnbTugas(),
    BnbSetting(),
  ];
  void ontap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff85CBCB),
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: body[currentIndex],
        bottomNavigationBar: BottomAppBar(
          color: Color(0xffFFF5EA),
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: width / 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.book),
                  onPressed: () => ontap(0),
                  color:
                      currentIndex == 0 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
                ),
                IconButton(
                  icon: Icon(Icons.perm_contact_cal),
                  onPressed: () => ontap(1),
                  color:
                      currentIndex == 1 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
                ),
                SizedBox(
                  width: width / 10,
                ),
                IconButton(
                  icon: Icon(Icons.assignment),
                  onPressed: () => ontap(2),
                  color:
                      currentIndex == 2 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => ontap(3),
                  color:
                      currentIndex == 3 ? Color(0xff85CBCB) : Color(0xffB3B3B3),
                ),
              ],
            ),
          ),
        ));
  }
}
