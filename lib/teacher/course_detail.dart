import 'package:apk_kelas_king/bnb.dart';
import 'package:apk_kelas_king/model/container.dart';
import 'package:apk_kelas_king/model/show/absensi.dart';
import 'package:apk_kelas_king/model/show/anggota.dart';
import 'package:flutter/material.dart';
import '../model/other.dart';

// ignore: must_be_immutable
class TCourseDetail extends StatefulWidget {
  final Map datacourse;
  final Map datauser;
  Color color;
  TCourseDetail({
    required this.datacourse,
    required this.datauser,
    required this.color,
  });

  @override
  State<TCourseDetail> createState() => _TCourseDetailState();
}

popup(String popup, context, datacourse, datauser) {
  if (popup == "Anggota") {
    showDialog(
        context: context,
        builder: (context) {
          return PopUpAnggota(datacourse: datacourse);
        });
  } else if (popup == "Absensi") {
    showDialog(
        context: context,
        builder: (context) {
          return PopUpAbsensi(datacourse: datacourse, datauser: datauser);
        });
  }
}

class _TCourseDetailState extends State<TCourseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: widget.color.withOpacity(0.7),
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          BgDetilCourse(nama: widget.datacourse['nama'], color: widget.color),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
            child: Judul(txt: 'Detail Course'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                DetailItem(
                  judul: "Pengajar",
                  data: widget.datacourse['namaguru'],
                  icon: Icon(
                    Icons.school,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: DetailItem(
                    judul: "Kode Course",
                    data: widget.datacourse['course_id'].toString(),
                    icon: Icon(
                      Icons.key,
                      size: 15,
                    ),
                  ),
                ),
                DetailItem(
                  icon: Icon(
                    Icons.people,
                    size: 15,
                  ),
                  judul: "Anggota Course",
                  op: () {
                    popup(
                        "Anggota", context, widget.datacourse, widget.datauser);
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 10),
                    child: widget.datacourse['absen'] == 'no'
                        ? DetailItem(
                            icon: Icon(
                              Icons.check_circle,
                              size: 15,
                            ),
                            judul: "Buat Absensi",
                            op: () {
                              popup("Absensi", context, widget.datacourse,
                                  widget.datauser);
                            },
                          )
                        : DetailItem(
                            icon: Icon(
                              Icons.check_circle,
                              size: 15,
                            ),
                            judul: "Detail absensi",
                            op: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Bnb(
                                          datauser: widget.datauser, idx: 1)));
                            },
                          )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Judul(txt: 'Materi'),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff85CBCB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      'Buat Materi',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.color,
                  ),
                  child: Text(
                    'Materiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              })
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailItem extends StatelessWidget {
  final String? judul;
  final Function()? op;
  final String? data;
  final Icon? icon;

  DetailItem({
    this.judul,
    this.data,
    this.icon,
    this.op,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 12, child: icon),
        SizedBox(
          width: 6,
        ),
        op == null
            ? Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(data ?? ''),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  op!();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff85CBCB),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      judul ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
