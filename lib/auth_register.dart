import 'package:flutter/material.dart';
import 'package:kelas_king/auth_login.dart';
import 'package:kelas_king/bnb.dart';
import 'package:kelas_king/model/bg.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/other.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool valuecheck = false;
  bool value = false;

  String? selectedRole;

  List<String> items = ['Pelajar', 'Pengajar'];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    var width = MediaQuery.of(context).size.width;
    Future register() async {
      try {
        var response =
            await http.post(Uri.parse(currentUrl + 'api/register'), body: {
          "nama": _namaController.text,
          "role": selectedRole,
          "email": _emailController.text,
          "password": _passwordController.text
        });
        Map data = json.decode(response.body);
        String message = data['message'];
        if (message == 'Register berhasil') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Bnb(data: data)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Eror(msg: message, width: width);
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
            Image.asset('images/bgup.png'),
            Image.asset('images/bgdown.png'),
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
                          TxtSub(txt: 'Register'),
                          Padding(
                            padding: EdgeInsets.only(
                                top: width / 30, bottom: width / 50),
                            child: TxtField(
                              validator: 'isi nama',
                              controller: _namaController,
                              hint: 'Nama',
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
                              hintText: 'Role',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            value: selectedRole,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'pilih role';
                              }
                              return null;
                            },
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
                            padding: EdgeInsets.symmetric(vertical: width / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity(horizontal: -4),
                                  activeColor: Color(0xff85CBCB),
                                  value: valuecheck,
                                  onChanged: (v) {
                                    setState(() {
                                      valuecheck = !valuecheck;
                                    });
                                  },
                                  side: BorderSide(
                                      color: Colors.grey, width: 1.3),
                                ),
                                TxtSmall(txt: 'Setuju dengan '),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Syarat & Ketentuan',
                                        style:
                                            TextStyle(color: Color(0xff85CBCB)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Button(
                              button: 'Register',
                              color: Color(0xff85CBCB),
                              shadow: Color(0xffA8DEE0),
                              fun: () async {
                                if (_formKey.currentState!.validate()) {
                                  register();
                                }
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: width / 40),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Button(
                            button: 'Login',
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
