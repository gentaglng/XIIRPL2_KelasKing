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
    print(waktu + hari + tanggal + bulan + tahun);

    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //getabsen
    Future getAbsen() async {
      try {
        var response = await http
            .post(Uri.parse(currentUrl + 'api/course/absen/today'), body: {
          "user_id": widget.data['data']['id'].toString(),
          "hari": hari
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder(
                future: getAbsen(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data['data'] != null
                        ? ItemContainer(
                            width: width,
                            color: Colors.black,
                            tx: 'Nama course')
                        : Text(
                            snapshot.data['message'],
                            textAlign: TextAlign.center,
                          );
                  } else {
                    return Loading();
                  }
                }),
          )
        ],
      ),
    );
  }
}
