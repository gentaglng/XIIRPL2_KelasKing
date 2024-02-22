import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelas_king/course_detail.dart';
import 'package:kelas_king/model/other.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/url.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class BnbCourseAdmin extends StatelessWidget {
  Map data;
  BnbCourseAdmin({required this.data});
  final List<Widget> image = [
    Image.asset('images/bg11.png'),
    Image.asset('images/bg12.png'),
    Image.asset('images/bg13.png'),
  ];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    var width = MediaQuery.of(context).size.width;
    Future getCourse() async {
      try {
        var response = await http.get(Uri.parse(currentUrl +
            'api/course/get/instructor/' +
            data['data']['id'].toString()));
        Map dataa = json.decode(response.body);
        String message = dataa['message'];
        if (message == 'Course berhasil didapatkan') {
          return json.decode(response.body);
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Eror(msg: message, width: width);
              });
        }
      } catch (e) {
        Future.delayed(Duration.zero, () {
          showDialog(
              context: context,
              builder: (context) {
                return Eror(msg: e.toString(), width: width);
              });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: TxtSub(txt: 'Home'),
        actions: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Judul(txt: 'Your Course'),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Color(0xff85CBCB),
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                  future: getCourse(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
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
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CourseDetail(
                                              data: snapshot.data['data']
                                                  [index],
                                              img: (index + 1).toString(),
                                            )));
                              },
                              child: Stack(
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
                                          child: TxtNormal(
                                              txt: snapshot.data['data'][index]
                                                  ['nama'],
                                              weight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text('kosong');
                    }
                  }))
        ],
      ),
    );
  }
}
