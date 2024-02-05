import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  final String hint;
  TxtField({required this.hint});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: width / 20, top: width / 20, bottom: width / 20),
              hintText: hint,
              hintStyle: TextStyle(fontSize: width / 20),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width / 20),
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width / 20),
                  borderSide: BorderSide(color: Colors.black, width: 1))),
          style: TextStyle(fontSize: width / 20),
        ),
      ],
    );
  }
}

class TxtPw extends StatefulWidget {
  final String hint;
  TxtPw({required this.hint});

  @override
  State<TxtPw> createState() => _TxtPwState();
}

class _TxtPwState extends State<TxtPw> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
        obscureText: _obscure,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: width / 20, top: width / 20, bottom: width / 20),
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                child: _obscure
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Icon(
                          Icons.visibility_off,
                          color: Color(0xff6E78FF),
                          size: width / 16,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 20),
                        child: Icon(
                          Icons.visibility,
                          color: Color(0xff6E78FF),
                          size: width / 16,
                        ),
                      )),
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: width / 20),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width / 20),
                borderSide: BorderSide(color: Colors.grey, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width / 20),
                borderSide: BorderSide(color: Colors.black, width: 1))),
        style: TextStyle(fontSize: width / 20));
  }
}
