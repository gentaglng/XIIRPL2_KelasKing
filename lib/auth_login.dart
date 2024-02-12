import 'package:flutter/material.dart';
import 'package:kelas_king/auth_forgotpw.dart';
import 'package:kelas_king/auth_register.dart';
import 'package:kelas_king/bnb.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthLogin extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future login() async {
      var response = await http
          .post(Uri.parse('http://10.212.67.180:8000/api/login'), body: {
        "email": _emailController.text,
        "password": _passwordController.text
      });
      Map data = json.decode(response.body);
      print(data);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Bnb(data: data)));
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'images/bg2.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width / 15, right: width / 15, top: width / 1.5),
              child: Bg(
                  child: Padding(
                padding: EdgeInsets.all(width / 15),
                child: Column(
                  children: [
                    TxtSub(txt: 'Sign in'),
                    Padding(
                      padding:
                          EdgeInsets.only(top: width / 30, bottom: width / 50),
                      child: TxtField(
                        controller: _emailController,
                        hint: 'Enter your email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TxtPw(
                      hint: 'Enter your password',
                      controller: _passwordController,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: width / 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthForgotpw()));
                              },
                              child: TxtSmall(txt: 'Forgot password?')),
                        ],
                      ),
                    ),
                    Button(
                      button: 'Sign In',
                      color: Color(0xff85CBCB),
                      shadow: Color(0xffA8DEE0),
                      fun: () async {
                        login();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: width / 40),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Button(
                      button: 'Sign Up',
                      color: Color(0xffFBC78D),
                      shadow: Color(0xffF9E2AE),
                      fun: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthRegister()));
                      },
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
