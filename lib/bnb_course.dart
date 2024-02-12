import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kelas_king/course_detail.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kelas_king/url.dart';
import 'package:provider/provider.dart';

class BnbCourse extends StatelessWidget {
  Map data;
  BnbCourse({required this.data});
  final List<Widget> image = [
    Image.asset('images/bg11.png'),
    Image.asset('images/bg12.png'),
    Image.asset('images/bg13.png'),
  ];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    Future getCourse() async {
      var response = await http.get(Uri.parse(currentUrl +
          'api/course/get/user/' +
          data['data'][0]['id'].toString()));
      return json.decode(response.body);
    }

    var width = MediaQuery.of(context).size.width;
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
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: width,
                  height: width / 1.5,
                  color: Colors.black,
                ),
                Container(
                  width: width,
                  height: width / 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(width / 30))),
                )
              ],
            ),
            Search(),
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
                                                  [index])));
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
                                                txt: snapshot.data['data']
                                                    [index]['nama'],
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
        ));
  }
}
