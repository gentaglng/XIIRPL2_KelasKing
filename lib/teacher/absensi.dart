import 'dart:convert';

import 'package:apk_kelas_king/model/null.dart';
import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TAbsensi extends StatelessWidget {
  final Map datauser;
  TAbsensi({required this.datauser});

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //future
    Future getRekapAbsenTeacher() async {
      try {
        var response = await http.get(
          Uri.parse(currentUrl +
              'api/absen/rekap/pengajar/' +
              datauser['data']['id'].toString()),
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
              child: datauser['data']['role'] == 'Pelajar'
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
            padding:
                const EdgeInsets.only(top: 8, left: 10, bottom: 10, right: 10),
            child: Judul(txt: 'Daftar Absensi Course'),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
              child: FutureBuilder(
                  future: getRekapAbsenTeacher(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data['message'] ==
                              "Berhasil mendapatkan data"
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                String mulai =
                                    snapshot.data['data'][index]['mulai'];
                                String selesai =
                                    snapshot.data['data'][index]['selesai'];
                                String jam = mulai + ' - ' + selesai;
                                String hari =
                                    snapshot.data['data'][index]['hari'];
                                String hariFormatted = '';

                                for (var i = 0; i < hari.length; i++) {
                                  if (hari[i].codeUnitAt(0) >= 65 &&
                                      hari[i].codeUnitAt(0) <= 90) {
                                    if (i > 0) {
                                      hariFormatted += ', ';
                                    }
                                    hariFormatted += hari[i];
                                  } else {
                                    hariFormatted += hari[i];
                                  }
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.orangeAccent
                                            .withOpacity(0.4)),
                                    child: Column(
                                      children: [
                                        Image.asset('images/top.png'),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data['data']
                                                          [index]['nama'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Text(hariFormatted),
                                                    Text(
                                                      jam,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PopUp(
                                                            title:
                                                                "Rekap Absensi Pelajar",
                                                            form: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Judul(
                                                                    txt:
                                                                        'Data'),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: DataTable(
                                                                      headingRowColor:
                                                                          MaterialStateColor.resolveWith((states) =>
                                                                              Color(0xffA8DEE0)),
                                                                      columns: [
                                                                        DataColumn(
                                                                          label:
                                                                              Text('No'),
                                                                        ),
                                                                        DataColumn(
                                                                            label:
                                                                                Text('Nama Pelajar')),
                                                                        DataColumn(
                                                                            label:
                                                                                Text('Keterangan')),
                                                                        DataColumn(
                                                                            label:
                                                                                Text('Tanggal')),
                                                                        DataColumn(
                                                                            label:
                                                                                Text('Waktu')),
                                                                        DataColumn(
                                                                            label:
                                                                                Text('Lain-lain')),
                                                                      ],
                                                                      rows: [
                                                                        DataRow(
                                                                            cells: [
                                                                              DataCell(Text(
                                                                                'data',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              )),
                                                                              DataCell(Text('data')),
                                                                              DataCell(Text('data')),
                                                                              DataCell(Text('data')),
                                                                              DataCell(Text('data')),
                                                                              DataCell(Text('data')),
                                                                            ]),
                                                                      ]),
                                                                ),
                                                              ],
                                                            ));
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.green
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 15),
                                                    child: Text(
                                                      "Rekap Absensi Pelajar",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: DataNull(txt: snapshot.data['message']),
                            );
                    } else {
                      return Text('Loading');
                    }
                  }))
        ],
      ),
    );
  }
}
