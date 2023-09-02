

import 'package:flutter/material.dart';

import '../constaint.dart';

class SearchBa_r extends StatelessWidget {
  final pink = kPrimaryColor;
  final grey =kprimaryLightColor;

  const SearchBa_r({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabled: true,
          filled: true,
          fillColor:kprimaryLightColor,
           
          focusColor: kPrimaryColor,
          focusedBorder: _border(kPrimaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0),),
          enabledBorder: _border(kPrimaryColor),
          
alignLabelWithHint: false,
          hintText: 'Start brand search',

          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(width: 0.5, color: color),
    borderRadius: BorderRadius.circular(50.0),
  );
}