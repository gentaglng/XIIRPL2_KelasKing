import 'package:flutter/material.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        ClipRRect(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(width / 15)),
            child: Image.asset(
              'images/bg1.png',
            )),
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 15, vertical: width / 2),
              child: Bg(
                  child: Padding(
                padding: EdgeInsets.all(width / 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TxtField(hint: 'Enter your Email'),
                    TxtPw(hint: 'Enter your password'),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: width / 20),
                      child: Txt(
                          txt: 'Forgot password?',
                          weight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    Button(
                      button: 'Sign In',
                      color: Color(0xff85CBCB),
                      shadow: Color(0xffA8DEE0),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Button(
                      button: 'Sign Up',
                      color: Color(0xffFBC78D),
                      shadow: Color(0xffF9E2AE),
                    ),
                  ],
                ),
              )),
            ),
          ],
        )
      ],
    ));
  }
}
