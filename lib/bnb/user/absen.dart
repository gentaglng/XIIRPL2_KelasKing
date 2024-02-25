import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kelas_king_apk/model/container.dart';
import 'package:kelas_king_apk/model/loading.dart';
import 'package:kelas_king_apk/model/other.dart';
import 'package:kelas_king_apk/model/show.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:kelas_king_apk/url.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class UserAbsen extends StatefulWidget {
  Map data;
  UserAbsen({
    required this.data,
  });

  @override
  State<UserAbsen> createState() => _UserAbsenState();
}

class _UserAbsenState extends State<UserAbsen> {
  String waktu = '';
  String hari = '';
  String tanggal = '';
  String bulan = '';
  String tahun = '';
  @override
  void initState() {
    super.initState();
    _date();
  }

  void _date() {
    final String formattedWaktu = DateFormat('HH:mm').format(DateTime.now());
    final String formattedHari =
        DateFormat('EEEE', 'id_ID').format(DateTime.now());
    final String formattedTanggal =
        DateFormat('dd', 'id_ID').format(DateTime.now());
    final String formattedBulan =
        DateFormat('MMMM', 'id_ID').format(DateTime.now());
    final String formattedTahun =
        DateFormat('yyyy', 'id_ID').format(DateTime.now());

    setState(() {
      waktu = formattedWaktu;
      hari = formattedHari;
      tanggal = formattedTanggal;
      bulan = formattedBulan;
      tahun = formattedTahun;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //getabsen
    Future getAbsen() async {
      try {
        var response = await http
            .post(Uri.parse(currentUrl + 'api/course/absen/today'), body: {
          "user_id": widget.data['data']['id'].toString(),
          "hari": hari,
          "tanggal": tanggal,
          "bulan": bulan,
          "tahun": tahun
        });
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

    Widget sudahbelum(String pesan, snapshot) {
      if (pesan == 'Kamu sudah absen semua') {
        return Column(
          children: [
            Judul(tx: 'Belum absen'),
            Text(pesan),
            Judul(tx: 'Sudah absen'),
            SizedBox(
              height: width / 2.5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: ((context, index) {
                    return ItemContainerDone(
                        keterangan: snapshot.data['data'][index]['keterangan'],
                        width: width,
                        color: Color(0xff85CBCB),
                        bg: Color(0xffD1EBD2),
                        tx: snapshot.data['data'][index]['nama'],
                        waktu: snapshot.data['data'][index]['waktu']);
                  })),
            )
          ],
        );
      } else if (pesan == 'Kamu belum absen semua') {
        return Column(
          children: [
            Judul(tx: 'Belum absen'),
            SizedBox(
              height: width / 2.3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    String mulai = snapshot.data['data'][index]['mulai'];
                    String selesai = snapshot.data['data'][index]['selesai'];
                    return ItemContainer(
                        width: width,
                        color: Colors.red.withOpacity(0.8),
                        bg: Color(0xffFFD5D4),
                        tx: snapshot.data['data'][index]['nama'],
                        waktu: mulai + ' sd ' + selesai,
                        fun: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AbsenShow(
                                  data: widget.data,
                                  course_id: snapshot.data['data'][index]
                                      ['course_id'],
                                  user_id: snapshot.data['data'][index]
                                      ['user_id'],
                                );
                              });
                        });
                  }),
            ),
            Judul(tx: 'Sudah absen'),
            Text(pesan),
          ],
        );
      } else {
        return Column(
          children: [
            Judul(tx: 'Belum absen'),
            SizedBox(
              height: width / 2.3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data['belumabsen'].length,
                  itemBuilder: (context, index) {
                    String mulai = snapshot.data['belumabsen'][index]['mulai'];
                    String selesai =
                        snapshot.data['belumabsen'][index]['selesai'];
                    return ItemContainer(
                        width: width,
                        color: Colors.red.withOpacity(0.8),
                        bg: Color(0xffFFD5D4),
                        tx: snapshot.data['belumabsen'][index]['nama'],
                        waktu: mulai + ' sd ' + selesai,
                        fun: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AbsenShow(
                                  data: widget.data,
                                  course_id: snapshot.data['belumabsen'][index]
                                      ['course_id'],
                                  user_id: snapshot.data['belumabsen'][index]
                                      ['user_id'],
                                );
                              });
                        });
                  }),
            ),
            Judul(tx: 'Sudah absen'),
            SizedBox(
              height: width / 2.5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data['sudahabsen'].length,
                  itemBuilder: ((context, index) {
                    return ItemContainerDone(
                        keterangan: snapshot.data['sudahabsen'][index]
                            ['keterangan'],
                        width: width,
                        color: Color(0xff85CBCB),
                        bg: Color(0xffD1EBD2),
                        tx: snapshot.data['sudahabsen'][index]['nama'],
                        waktu: snapshot.data['sudahabsen'][index]['waktu']);
                  })),
            )
          ],
        );
      }
    }

    //getcourse
    Future getCourse() async {
      try {
        var response = await http.get(Uri.parse(currentUrl +
            'api/course/pelajar/' +
            widget.data['data']['id'].toString()));

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
          'Absensi',
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
              child: widget.data['data']['role'] == 'Pelajar'
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
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('images/night.png'),
              Column(
                children: [
                  Text(
                    hari,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 30),
                  ),
                  Text(
                    tanggal + ', ' + bulan + ' ' + tahun,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(
                    height: width / 10,
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 8),
            child: FutureBuilder(
                future: getAbsen(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data['message'] !=
                            'Tidak ada absen hari ini'
                        ? sudahbelum(snapshot.data['message'], snapshot)
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              snapshot.data['message'],
                              textAlign: TextAlign.center,
                            ),
                          );
                  } else {
                    return Loading();
                  }
                }),
          ),
          Judul(tx: 'Rekap bulan ' + bulan),
        ],
      ),
    );
  }
}
