import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';

class BnbCourse extends StatelessWidget {
  final List<Widget> image = [
    Image.asset('images/bg11.png'),
    Image.asset('images/bg12.png'),
    Image.asset('images/bg13.png'),
  ];

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF9E2AE),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(8)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: TxtNormal(
                        txt: 'Your Course',
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
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
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
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
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 7),
                                  child: TxtNormal(
                                      txt: 'Tessssssssssssssssssssssssssssssss',
                                      weight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
