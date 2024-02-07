import 'package:flutter/material.dart';

class AuthForgotpw extends StatelessWidget {
  const AuthForgotpw({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
