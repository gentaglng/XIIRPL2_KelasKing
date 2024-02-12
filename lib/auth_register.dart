import 'package:flutter/material.dart';
import 'package:kelas_king/auth_login.dart';
import 'package:kelas_king/bnb.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kelas_king/url.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class AuthRegister extends StatefulWidget {
  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool value = false;

  String? selectedRole;

  List<String> items = ['Teacher', 'Student'];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    Future register() async {
      var response =
          await http.post(Uri.parse(currentUrl + 'api/register'), body: {
        "nama": _namaController.text,
        "role": selectedRole,
        "email": _emailController.text,
        "password": _passwordController.text
      });
      Map data = json.decode(response.body);
      print(data);
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
                    TxtSub(txt: 'Sign Up'),
                    Padding(
                      padding:
                          EdgeInsets.only(top: width / 30, bottom: width / 50),
                      child: TxtField(
                        controller: _namaController,
                        hint: 'Kimi no namaewaa?',
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: width / 30),
                          child: Icon(
                            Icons.groups_3,
                            color: Colors.grey,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        hintText: 'Select role',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      value: selectedRole,
                      items: items
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRole = newValue as String?;
                          value = (selectedRole != null);
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: width / 50),
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
                      padding: EdgeInsets.symmetric(vertical: width / 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Check(),
                          TxtSmall(txt: 'I read and accept Terms of Service')
                        ],
                      ),
                    ),
                    Button(
                        button: 'Sign Up',
                        color: Color(0xff85CBCB),
                        shadow: Color(0xffA8DEE0),
                        fun: () async {
                          register();
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: width / 40),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Button(
                      button: 'Sign In',
                      color: Color(0xffFBC78D),
                      shadow: Color(0xffF9E2AE),
                      fun: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthLogin()));
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
