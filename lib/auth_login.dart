import 'package:flutter/material.dart';
import 'package:kelas_king/model/button.dart';
import 'package:kelas_king/model/txt.dart';
import 'package:kelas_king/model/txtfield.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                      txt: 'Email',
                      left: width / 40,
                      size: width / 22,
                      weight: FontWeight.normal),
                  TxtField(
                    hint: 'Enter your email',
                  ),
                  Txt(
                      txt: 'Password',
                      left: width / 40,
                      size: width / 22,
                      weight: FontWeight.normal),
                  TxtPw(hint: 'Enter your password'),
                  Button(button: 'Sign In'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
