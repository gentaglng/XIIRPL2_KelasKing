import 'package:flutter/material.dart';
import 'package:kelas_king_apk/model/button.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Text('Pengaturan'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: width / 3,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: width / 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.1)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                'datadatadatadatadatadatadata',
                                textAlign: TextAlign.center,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hallo'),
                          Text(
                            'txttxttxttxttxttxttxttxttxttxttxttxttxttxttxttxttxt',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Button(
                      tx: 'Edit Profile',
                      color: Color(0xff85CBCB),
                      shadow: Color(0xffA8DEE0),
                      fun: () {}),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Button(
                        tx: 'Hubungi Admin',
                        color: Color(0xff85CBCB),
                        shadow: Color(0xffA8DEE0),
                        fun: () {}),
                  ),
                  Button(
                      tx: 'Kritik & Saran',
                      color: Color(0xff85CBCB),
                      shadow: Color(0xffA8DEE0),
                      fun: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                      tx: 'Log Out',
                      color: Color(0xffFF6962),
                      shadow: Color(0xffFF6962).withOpacity(0.1),
                      fun: () {})
                ],
              ),
            )
          ],
        ));
  }
}
