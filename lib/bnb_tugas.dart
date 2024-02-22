import 'package:flutter/material.dart';
import 'package:kelas_king/model/txt.dart';

class BnbTugas extends StatelessWidget {
  const BnbTugas({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: TxtSub(txt: 'Tugas'),
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
              children: [
                Judul(txt: 'Sudah Deadline'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Container(
                            height: width / 4,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              color: Color(0xffFF6962),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Container(
                              width: width / 1.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 1,
                                        offset: Offset(0, 1))
                                  ],
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenska',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.red),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            child: Text(
                                              'Kerjakan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 10),
            child: Row(
              children: [
                Judul(txt: 'Belum Dikerjakan'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Container(
                            height: width / 4,
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              color: Color(0xffFF964F),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: width / 1.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 1,
                                        offset: Offset(0, 1))
                                  ],
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'BrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenska',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.orange),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            child: Text(
                                              'Kerjakan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Judul(txt: 'Sudah Dikerjakan'),
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => Padding(
                    padding: EdgeInsets.only(top: 10, left: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF9E2AE),
                        borderRadius: BorderRadius.circular(width / 20),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text(
                          'AbsenAbsenAbsenAbsen',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff77DD76),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                      ),
                    ),
                    Container(
                      width: width / 1.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                offset: Offset(0, 1))
                          ],
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenskaBrzenska',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.green),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    child: Text(
                                      'Detail',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
