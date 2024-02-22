import 'package:flutter/material.dart';
import 'package:kelas_king/auth_forgotpw.dart';
import 'package:kelas_king/auth_register.dart';
import 'package:kelas_king/bnb.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/other.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'package:kelas_king/url.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AuthLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    String warning = '';
    Future login() async {
      try {
        var response = await http.post(Uri.parse(currentUrl + 'api/login'),
            body: {
              "email": _emailController.text,
              "password": _passwordController.text
            });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Login berhasil') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Bnb(data: data)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Warning(msg: message, width: width);
              });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return Eror(msg: e.toString(), width: width);
            });
      }
    }

    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/bgup.png',
            ),
            Image.asset(
              'images/bgdown.png',
            ),
          ],
        ),
        ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width / 15,
                  right: width / 15,
                  bottom: width / 10,
                  top: width / 10),
              child: Column(
                children: [
                  Image.asset(
                    'images/logo_black.png',
                    height: width / 3,
                  ),
                  SizedBox(
                    height: width / 10,
                  ),
                  Bg(
                      child: Padding(
                    padding: EdgeInsets.all(width / 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TxtSub(txt: 'Login'),
                          Padding(
                            padding: EdgeInsets.only(
                                top: width / 30, bottom: width / 50),
                            child: TxtField(
                              validator: 'isi email',
                              controller: _emailController,
                              hint: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          TxtPw(
                            hint: 'Password',
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
                                              builder: (context) =>
                                                  AuthForgotpw()));
                                    },
                                    child: TxtSmall(txt: 'Lupa password?')),
                              ],
                            ),
                          ),
                          Button(
                            button: 'Login',
                            color: Color(0xff85CBCB),
                            shadow: Color(0xffA8DEE0),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: width / 40),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Button(
                            button: 'Register',
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
                    ),
                  )),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
