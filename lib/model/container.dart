import 'package:apk_kelas_king/student/course_detail.dart';
import 'package:apk_kelas_king/teacher/course_detail.dart';
import 'package:flutter/material.dart';

class ContainerCourse extends StatelessWidget {
  final List<Color> color = [
    Color(0xffDEDAF4),
    Color(0xffD9EDF8),
    Color(0xffE4F1EE),
  ];

  final snapshot;
  final String role;
  ContainerCourse({
    required this.snapshot,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data['data'].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              role == 'Pelajar'
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetail(
                              datacourse: snapshot.data['data'][index])))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TCourseDetail(
                              color: color[index % color.length],
                              datacourse: snapshot.data['data'][index])));
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: color[index % color.length],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8))),
                    child: Column(
                      children: [
                        Image.asset(
                          'images/top.png',
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: width / 15, left: 10),
                                child: Icon(
                                  Icons.book,
                                  size: width / 7,
                                  color: Colors.black.withOpacity(0.05),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'images/bottom.png',
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data['data'][index]['nama'],
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 6),
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.school,
                                  size: 15,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                snapshot.data['data'][index]['namaguru'],
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class BgDetilCourse extends StatelessWidget {
  final String nama;
  final Color color;
  BgDetilCourse({
    required this.nama,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: Column(
          children: [
            Image.asset('images/top.png'),
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, bottom: 30, top: 10),
              child: Text(
                nama,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Image.asset('images/bottom.png'),
          ],
        ));
  }
}
