import 'package:apk_kelas_king/model/other.dart';
import 'package:apk_kelas_king/model/show.dart';
import 'package:flutter/material.dart';

class TAbsensi extends StatelessWidget {
  final Map datauser;
  TAbsensi({required this.datauser});

  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orangeAccent.withOpacity(0.4)),
                      child: Column(
                        children: [
                          Image.asset('images/top.png'),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nama Course',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text('Hari'),
                                      Text(
                                        'Waktu',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                              title: "Rekap Absensi Pelajar",
                                              form: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Judul(txt: 'Data'),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: DataTable(
                                                        headingRowColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Color(
                                                                            0xffA8DEE0)),
                                                        columns: [
                                                          DataColumn(
                                                            label: Text('No'),
                                                          ),
                                                          DataColumn(
                                                              label: Text(
                                                                  'Nama Pelajar')),
                                                          DataColumn(
                                                              label: Text(
                                                                  'Keterangan')),
                                                          DataColumn(
                                                              label: Text(
                                                                  'Tanggal')),
                                                          DataColumn(
                                                              label: Text(
                                                                  'Waktu')),
                                                          DataColumn(
                                                              label: Text(
                                                                  'Lain-lain')),
                                                        ],
                                                        rows: [
                                                          DataRow(cells: [
                                                            DataCell(Text(
                                                              'data',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                            DataCell(
                                                                Text('data')),
                                                            DataCell(
                                                                Text('data')),
                                                            DataCell(
                                                                Text('data')),
                                                            DataCell(
                                                                Text('data')),
                                                            DataCell(
                                                                Text('data')),
                                                          ]),
                                                        ]),
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 15),
                                      child: Text(
                                        "Rekap Absensi Pelajar",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                }),
          )
        ],
      ),
    );
  }
}
