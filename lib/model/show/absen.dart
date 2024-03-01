import 'dart:convert';

import 'package:apk_kelas_king/bnb.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:apk_kelas_king/url.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AbsenShow extends StatefulWidget {
  final Map datauser;
  final String course_id;
  AbsenShow({
    required this.datauser,
    required this.course_id,
  });
  @override
  State<AbsenShow> createState() => _AbsenShowState();
}

class _AbsenShowState extends State<AbsenShow> {
  String _selectedValue = '';

  void _handleRadioValueChanged(String? value) {
    setState(() {
      _selectedValue = value.toString();
    });
  }

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
    String date = hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun;
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //future
    Future absenToday(String keterangan) async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response =
            await http.post(Uri.parse(currentUrl + 'api/absen/today'), body: {
          "course_id": widget.course_id,
          "user_id": widget.datauser['data']['id'].toString(),
          "keterangan": keterangan,
          "hari": hari,
          "tanggal": tanggal,
          "bulan": bulan,
          "tahun": tahun,
          "waktu": waktu
        });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Absensi berhasil') {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Bnb(datauser: widget.datauser, idx: 1)));
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return Eror(txt: message);
              });
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Eror(txt: e.toString());
            });
      }
    }

    //function
    pilihabsen() {
      if (_selectedValue == 'Masuk') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absenToday("Masuk");
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (_selectedValue == 'Izin') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child: Container(
                      height: width / 1.5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo,
                            size: width / 6,
                            color: Colors.grey,
                          ),
                          Text(
                            'Foto Surat Izin',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absenToday("Izin");
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (_selectedValue == 'Sakit') {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffA8DEE0).withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(waktu),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child: Container(
                      height: width / 1.5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo,
                            size: width / 6,
                            color: Colors.grey,
                          ),
                          Text(
                            'Foto Surat Sakit',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _date();
                        absenToday("Sakit");
                      });
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff85CBCB)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Kirim',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'pilih absensi!',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        );
      }
    }

    return PopUp(
        title: "Absensi",
        form: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 18, left: 10, right: 10, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Radio(
                        value: 'Masuk',
                        activeColor: Color(0xff85CBCB),
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChanged,
                        visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                      ),
                      Text(
                        'Masuk',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                        value: 'Izin',
                        activeColor: Color(0xff85CBCB),
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChanged,
                        visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                      ),
                      Text(
                        'Izin',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                        value: 'Sakit',
                        activeColor: Color(0xff85CBCB),
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChanged,
                        visualDensity: VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                      ),
                      Text(
                        'Sakit',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  )
                ],
              ),
            ),
            pilihabsen()
          ],
        ));
  }
}

// ignore: must_be_immutable
class DetailAbsen extends StatelessWidget {
  var data;
  String date;
  DetailAbsen({
    required this.data,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    print(data);
    return PopUp(
        title: "Detail Absensi",
        form: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['nama'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Keterangan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(data['keterangan'])
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tanggal Absensi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(date)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Waktu Absensi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(data['waktu'])
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
