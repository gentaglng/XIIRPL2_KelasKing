import 'package:flutter/material.dart';
import 'package:kelas_king_apk/model/loading.dart';
import 'package:kelas_king_apk/model/show.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kelas_king_apk/url.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AdminCourse extends StatelessWidget {
  Map data;
  AdminCourse({
    required this.data,
  });
  final List<Widget> image = [
    Image.asset('images/bg1.png'),
    Image.asset('images/bg2.png'),
    Image.asset('images/bg3.png'),
  ];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //var width = MediaQuery.of(context).size.width;
    //getcourse
    Future getCourse() async {
      try {
        var response = await http.get(Uri.parse(currentUrl +
            'api/course/pengajar/' +
            data['data']['id'].toString()));

        return json.decode(response.body);
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(tx: e.toString());
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder(
                future: getCourse(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data['data'] != null
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data['data'].length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: image[index % image.length]),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 50),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 7),
                                            child: Text(
                                              snapshot.data['data'][index]
                                                  ['nama'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                  ),
                                ],
                              );
                            },
                          )
                        : Column(
                            children: [
                              Text(snapshot.data['message']),
                              SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddCourse(data: data);
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff85CBCB),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Buat Course?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                  } else {
                    return Loading();
                  }
                }),
          )
        ],
      ),
    );
  }
}
