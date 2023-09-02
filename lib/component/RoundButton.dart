// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../constaint.dart';

class RoundButton extends StatelessWidget {
  final String text;
 void Function()? press;
  final color, textColor;

  RoundButton({
    Key? key,
    required this.text,
    this.press,
    required this.textColor, this.color,
  }) : super(key: key);
 
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: press,          
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          child: Text(text,
            style: TextStyle(color: textColor), ),
        ),
      ),
    );
  }
}
