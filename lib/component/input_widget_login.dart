// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constaint.dart';

class input_filed extends StatefulWidget {
  String hint;
  final IconData icon;
  TextEditingController controller;
   final Function valid;
  bool ipass;
  input_filed({
    Key? key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.valid,
    this.ipass = false,
  }) : super(key: key);

  @override
  State<input_filed> createState() => _input_filedState();
}

class _input_filedState extends State<input_filed> {
  late bool pass;
  

  @override
  void initState() {
    super.initState();
    pass = widget.ipass;}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        child: TextFormField(
          // validator: valid,
          obscureText:pass,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            focusColor: kPrimaryColor,
            focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: widget.ipass
                ? IconButton(
                    icon: Icon(pass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        pass = !pass;
                        print(pass);
                      });
                    },
                  )
                : null,
            prefixIcon: Icon(widget.icon),
            prefixIconColor: kPrimaryColor,
            border:const OutlineInputBorder(),
            label: Text(widget.hint),
          ),
        ),
      ),
    );
  }
}
