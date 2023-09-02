import 'package:flutter/material.dart';

import '../constaint.dart';

class divider extends StatelessWidget {
  const divider({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(  padding:EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                    children: <Widget>[
                      Expanded(
                  child: Divider(
                    color: Color(0xFFD9D9D9),
                    height: 2.5,
                  ),
                ),
                      Padding( 
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:  Text(
                "OR",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
                      ),
                     Expanded(
                  child: Divider(
                    color: Color(0xFFD9D9D9),
                    height: 2.5,
                  ),
                ),
                    ],
                  ),
            );
  }
}