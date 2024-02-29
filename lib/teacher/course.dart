import 'dart:convert';

import 'package:apk_kelas_king/model/container.dart';
import 'package:apk_kelas_king/model/null.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TCourse extends StatelessWidget {
  final Map datauser;
  TCourse({required this.datauser});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //future
    Future getCourseByTeacher() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/course/pengajar/' +
              datauser['data']['id'].toString()),
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
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          'Course',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LogOut();
                  });
            },
            child: CircleAvatar(
              child: datauser['data']['role'] == 'Pelajar'
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Judul(txt: 'Daftar Course'),
          ),
          FutureBuilder(
              future: getCourseByTeacher(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data['message'] ==
                          "Course berhasil didapatkan"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ContainerCourse(
                            snapshot: snapshot,
                            role: "Pengajar",
                          ),
                        )
                      : DataNull(txt: snapshot.data['message']);
                } else {
                  return Text('Loading');
                }
              })),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
