import 'package:flutter/material.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlertStudent extends StatelessWidget {
  Map data;
  AlertStudent({required this.data});
  TextEditingController _codeCourse = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future join() async {
      var response = await http
          .post(Uri.parse('http://10.212.67.180:8000/api/course/join'), body: {
        "user_id": data['data'][0]['id'].toString(),
        "course_id": _codeCourse.text
      });
      Map dataa = json.decode(response.body);
      print(dataa);
    }

    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtSub(txt: 'Join Course'),
              Padding(
                padding: EdgeInsets.only(top: width / 30, bottom: width / 20),
                child: TxtField(
                    controller: _codeCourse,
                    hint: 'Enter course code',
                    icon: Icon(Icons.key)),
              ),
              Button(
                  button: 'Join Course',
                  color: Color(0xff85CBCB),
                  shadow: Color(0xffA8DEE0),
                  fun: () async {
                    join();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertTeacher extends StatefulWidget {
  Map data;
  AlertTeacher({required this.data});
  @override
  State<AlertTeacher> createState() => _AlertTeacherState();
}

class _AlertTeacherState extends State<AlertTeacher> {
  TextEditingController _namaCourse = TextEditingController();
  bool value = false;

  String? yesOrNO;

  List<String> items = ['Buat', 'Tidak'];

  @override
  Widget build(BuildContext context) {
    Future add() async {
      var response = await http
          .post(Uri.parse('http://10.212.67.180:8000/api/course/add'), body: {
        "nama": _namaCourse.text,
        "instructor_id": widget.data['data'][0]['id'].toString(),
        "role": widget.data['data'][0]['role'],
        "absen": yesOrNO == 'Buat' ? '1' : '0'
      });
      Map dataa = json.decode(response.body);
      print(dataa);
    }

    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Bg(
        child: Padding(
          padding: EdgeInsets.all(width / 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TxtSub(txt: 'Create Course'),
              Padding(
                padding: EdgeInsets.only(top: width / 30, bottom: width / 50),
                child: TxtField(
                    controller: _namaCourse,
                    hint: 'Enter course name',
                    icon: Icon(Icons.book)),
              ),
              Padding(
                padding: EdgeInsets.only(top: width / 50, bottom: width / 20),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: width / 30),
                      child: Icon(
                        Icons.perm_contact_cal,
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
              ),
              Button(
                button: 'Create Course',
                color: Color(0xff85CBCB),
                shadow: Color(0xffA8DEE0),
                fun: () async {
                  add();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
