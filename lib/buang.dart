import 'package:flutter/material.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/other.dart';
import 'package:kelas_king/model/txt.dart';

class Buang extends StatefulWidget {
  const Buang({super.key});

  @override
  State<Buang> createState() => _BuangState();
}

class _BuangState extends State<Buang> {
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;

  button(c1, c2, c3) {
    if (c1) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.red,
      );
    } else if (c2) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.green,
      );
    } else if (c3) {
      return Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          TxtSub(txt: 'Matematika'),
          Row(
            children: [
              Judul(txt: 'Absen'),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.verified),
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4),
                    activeColor: Color(0xff85CBCB),
                    value: checkbox1,
                    onChanged: (v) {
                      setState(() {
                        checkbox1 = v!;
                        if (v!) {
                          checkbox2 = false;
                          checkbox3 = false;
                        }
                      });
                    },
                    side: BorderSide(color: Colors.grey, width: 1.3),
                  ),
                  TxtSmall(txt: 'Hadir'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4),
                    activeColor: Color(0xff85CBCB),
                    value: checkbox2,
                    onChanged: (v) {
                      setState(() {
                        checkbox2 = v!;
                        if (v!) {
                          checkbox1 = false;
                          checkbox3 = false;
                        }
                      });
                    },
                    side: BorderSide(color: Colors.grey, width: 1.3),
                  ),
                  TxtSmall(txt: 'Izin'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4),
                    activeColor: Color(0xff85CBCB),
                    value: checkbox3,
                    onChanged: (v) {
                      setState(() {
                        checkbox3 = v!;
                        if (v!) {
                          checkbox1 = false;
                          checkbox2 = false;
                        }
                      });
                    },
                    side: BorderSide(color: Colors.grey, width: 1.3),
                  ),
                  TxtSmall(txt: 'Sakit'),
                ],
              ),
            ],
          ),
          button(checkbox1, checkbox2, checkbox3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Judul(txt: 'Nilai'),
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
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Text(
                          'Rekap Nilai',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Rekap(
                color: Color(0xffB4DAF7),
              ),
              Rekap(
                color: Color(0xffB4F7C3),
              ),
              Rekap(
                color: Color(0xffF7ADB4),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Judul(txt: 'Materi & Tugas'),
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
          ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: width,
                  height: width / 20,
                  decoration: BoxDecoration(color: Colors.black),
                );
              })
        ],
      ),
    );
  }
}
