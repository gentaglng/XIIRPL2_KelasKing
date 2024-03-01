import 'dart:convert';

import 'package:apk_kelas_king/model/container.dart';
import 'package:apk_kelas_king/model/null.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Absensi extends StatefulWidget {
  final Map datauser;
  Absensi({required this.datauser});

  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
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

    //future
    Future getAbsenStudent() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/absen/pelajar/' +
              widget.datauser['data']['id'].toString() +
              '/' +
              hari +
              '/' +
              tanggal +
              '/' +
              bulan +
              '/' +
              tahun),
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

    //function
    Widget sudahbelum(String pesan, snapshot) {
      if (pesan == 'Kamu sudah absen semua') {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Judul(txt: 'Belum absen'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DataNull(txt: pesan),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Judul(txt: 'Sudah absen'),
              ),
              SizedBox(
                  height: width / 2.2,
                  child: ContainerAbsen(
                      date: hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun,
                      datauser: widget.datauser,
                      message: snapshot.data['message'],
                      snapshot: snapshot,
                      w: 2.2,
                      color: Colors.green)),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      } else if (pesan == 'Kamu belum absen semua') {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Judul(txt: 'Belum absen'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                    height: width / 2.2,
                    child: ContainerAbsen(
                        date: hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun,
                        datauser: widget.datauser,
                        message: snapshot.data['message'],
                        snapshot: snapshot,
                        w: 1.6,
                        color: Colors.red)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Judul(txt: 'Sudah absen'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DataNull(txt: pesan),
              )
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Judul(txt: 'Belum absen'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                    height: width / 2.2,
                    child: ContainerAbsen(
                        date: hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun,
                        datauser: widget.datauser,
                        message: snapshot.data['message'],
                        snapshot: snapshot,
                        w: 1.6,
                        color: Colors.red)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Judul(txt: 'Sudah absen'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 10),
                child: SizedBox(
                    height: width / 2.2,
                    child: ContainerAbsen(
                        date: hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun,
                        datauser: widget.datauser,
                        message: snapshot.data['message'],
                        snapshot: snapshot,
                        w: 2.2,
                        color: Colors.green)),
              )
            ],
          ),
        );
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
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LogOut();
                  });
            },
            child: CircleAvatar(
              child: widget.datauser['data']['role'] == 'Pelajar'
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
          Container(
            decoration:
                BoxDecoration(color: Color(0xffA8DEE0).withOpacity(0.3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('images/top.png'),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, left: 20, right: 20, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              hari,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tanggal + ' ' + bulan + ' ' + tahun,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width / 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff85CBCB),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Text(
                            "Rekap Bulan Ini",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: getAbsenStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data['message'] != 'Tidak ada absen hari ini'
                      ? sudahbelum(snapshot.data['message'], snapshot)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: DataNull(txt: snapshot.data['message']),
                        );
                } else {
                  return Text('Loading');
                }
              }),
        ],
      ),
    );
  }
}
