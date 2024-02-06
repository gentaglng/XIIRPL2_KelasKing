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
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: width / 30),
                child: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              hintText: hint,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        )
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
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: width / 30),
            child: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: width / 50),
            child: InkWell(
                onTap: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                child: _obscure
                    ? Icon(Icons.visibility_off, color: Colors.grey)
                    : Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          hintText: widget.hint,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
