import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_firebase/component/RoundButton.dart';
import 'package:todo_with_firebase/constaint.dart';
import 'package:todo_with_firebase/screen/login.dart';

class setting_screen extends StatefulWidget {
  const setting_screen({super.key});

  @override
  State<setting_screen> createState() => _setting_screenState();
}

class _setting_screenState extends State<setting_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SingleChildScrollView(
        child:Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          RoundButton(text: "Logout", textColor: kprimaryLightColor,color: kPrimaryColor,press:()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return login();
            }));

          })
        ]) ,
      ),),
    );
  }
}