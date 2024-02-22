import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kelas_king_apk/auth/login.dart';
import 'package:kelas_king_apk/bnb/bnb.dart';
import 'package:kelas_king_apk/model/bg.dart';
import 'package:kelas_king_apk/model/button.dart';
import 'package:kelas_king_apk/model/show.dart';
import 'package:kelas_king_apk/model/txtfield.dart';
import 'package:kelas_king_apk/url.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  bool value = false;

  String? selectedRole;

  bool valuecheck = false;

  String warning = '';

  List<String> items = ['Pelajar', 'Pengajar'];

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
    var currentUrl = urlProvider.url;
    //register
    Future register() async {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return Wait();
            });
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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: width / 30, bottom: width / 50),
                          child: TxtField(
                              controller: _namaController,
                              hint: 'Nama',
                              icon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              validator: 'isi nama'),
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
                              controller: _emailController,
                              hint: 'Email',
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              validator: 'isi email'),
                        ),
                        TxtFieldPw(controller: _passwordController),
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
                                side:
                                    BorderSide(color: Colors.grey, width: 1.3),
                              ),
                              Text('Setuju dengan '),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        warning == '' ? Container() : Warning(tx: warning),
                        Button(
                            tx: 'Register',
                            color: Color(0xff85CBCB),
                            shadow: Color(0xffA8DEE0),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                if (valuecheck == false) {
                                  setState(() {
                                    warning = 'Ceklis Syarat & Ketentuan';
                                  });
                                } else {
                                  register();
                                }
                              }
                            }),
                        Divider(
                          color: Colors.grey,
                        ),
                        Button(
                            tx: 'Login',
                            color: Color(0xffFBC78D),
                            shadow: Color(0xffF9E2AE),
                            fun: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
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
