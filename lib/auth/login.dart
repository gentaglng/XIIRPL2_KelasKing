import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelas_king_apk/auth/register.dart';
import 'package:kelas_king_apk/bnb/bnb.dart';
import 'package:kelas_king_apk/model/bg.dart';
import 'package:kelas_king_apk/model/button.dart';
import 'package:kelas_king_apk/model/show.dart';
import 'package:kelas_king_apk/model/txtfield.dart';
import 'package:kelas_king_apk/url.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String warning = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;

    //login
    Future login() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
        var response = await http.post(Uri.parse(currentUrl + 'api/login'),
            body: {
              "email": _emailController.text,
              "password": _passwordController.text
            });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Login berhasil') {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Bnb(
                        data: data,
                        state: 0,
                      )));
        } else {
          Navigator.pop(context);
          setState(() {
            warning = message;
          });
        }
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/bgup.png',
                height: height / 4,
                width: width,
                fit: BoxFit.fill,
              ),
              Image.asset(
                'images/bgdown.png',
                height: height / 4,
                width: width,
                fit: BoxFit.fill,
              ),
            ],
          ),
          ListView(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: width / 5, right: width / 5),
                child: Image.asset('images/logo.png'),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: width / 15, vertical: 20),
                child: Bg(
                    child: Padding(
                  padding: EdgeInsets.all(width / 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: width / 30, bottom: width / 50),
                          child: TxtField(
                              controller: _emailController,
                              hint: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              validator: 'isi email'),
                        ),
                        TxtFieldPw(controller: _passwordController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: width / 20),
                              child: InkWell(
                                  onTap: () {}, child: Text('Lupa password?')),
                            ),
                          ],
                        ),
                        warning == '' ? Container() : Warning(tx: warning),
                        Button(
                            tx: 'Login',
                            color: Color(0xff85CBCB),
                            shadow: Color(0xffA8DEE0),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            }),
                        Divider(
                          color: Colors.grey,
                        ),
                        Button(
                            tx: 'Register',
                            color: Color(0xffFBC78D),
                            shadow: Color(0xffF9E2AE),
                            fun: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            }),
                      ],
                    ),
                  ),
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
