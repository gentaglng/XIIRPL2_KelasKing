import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String validator;
  Icon icon;
  TxtField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validator;
            }
            return null;
          },
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              prefixIcon: Padding(
                  padding: EdgeInsets.only(right: width / 30), child: icon),
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
  final TextEditingController controller;
  TxtPw({
    required this.controller,
    required this.hint,
  });

  @override
  State<TxtPw> createState() => _TxtPwState();
}

class _TxtPwState extends State<TxtPw> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'isi password';
        }
        return null;
      },
      controller: widget.controller,
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

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintText: 'Search',
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(width / 20),
                borderSide: BorderSide(
                  color: Colors.grey,
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width / 20),
              borderSide: BorderSide(color: Colors.grey),
            )),
      ),
    );
  }
}
