// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../component/showdialoge.dart';
import '../component/social_media.dart';
import '../constaint.dart';
import '../screen/main_secreen.dart';
import '../screen/sinup.dart';

import 'package:firebase_storage/firebase_storage.dart';
import '../component/RoundButton.dart';
import '../component/input_widget_login.dart';
import '../component/or_divider.dart';
import '../component/social_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  login({
    Key? key,
  }) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> formstate = new GlobalKey();
  var myemaail, mypsssword;
  var scure_state = true;
  loginfunction() async {
    var formtemp = formstate.currentState;

    if (formtemp!.validate()) {
      formtemp.save();
      try {
        showloading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemaail, password: mypsssword);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
             Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: 'error',
                  body: Text('No user found for that email.'))
              .show();
           
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
             Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: 'error',
                  body: Text('Wrong password provided for that user.'))
              .show();
          print('Wrong password provided for that user.');
        }
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
    // pass = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formstate,
              child: Column(children: [
                Container(
                  width: 200,
                  height: 180,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset("assets/images/Logo.jpg"),
                ),
                SizedBox(
                  height: 75,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      child: TextFormField(
                        onSaved: (val) {
                          myemaail = val!;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "Email can't to be larger then 100";
                          }
                          if (value!.length < 2) {
                            return "Email can't to be less Two";
                          }
                          return null;
                        },
                        obscureText: false,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          focusColor: kPrimaryColor,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: kPrimaryColor,
                          border: const OutlineInputBorder(),
                          label: Text("User Email"),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      child: TextFormField(
                        onSaved: (val) {
                          mypsssword = val!;
                        },
                        validator: (value) {
                          if (value!.length > 100) {
                            return "Passwored can't to be larger then 100";
                          }
                          if (value!.length < 2) {
                            return "password can't to be less Two";
                          }
                          return null;
                        },
                        obscureText: scure_state,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          focusColor: kPrimaryColor,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: kPrimaryColor,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                scure_state = !scure_state;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                          label: Text("User Password"),
                        ),
                      ),
                    )),
                RoundButton(
                  text: "LOGIN",
                  press: () async {
                    // Navigator.of(context)
                    //     .pushReplacement(MaterialPageRoute(builder: (context) {
                    //   return main_secreen();
                    // }));
                    var user = await loginfunction();
                    if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return main_secreen();
                      }));
                    }
                  },
                  textColor: kprimaryLightColor,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                divider(),
                SizedBox(
                  height: 15,
                ),
                social_media(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return sinup();
                        }));
                      },
                      child: Text(
                        ' Sign In',
                        style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}


    //   padding:const EdgeInsets.symmetric(horizontal: 32),
    //   child: Container(
    //     child: TextFormField(
    //       validator: valid,
    //       obscureText:pass,
    //       cursorColor: kPrimaryColor,
    //       decoration: InputDecoration(
    //         focusColor: kPrimaryColor,
    //         focusedBorder:const OutlineInputBorder(
    //             borderSide: BorderSide(color: kPrimaryColor)),
    //         suffixIcon: widget.ipass
    //             ? IconButton(
    //                 icon: Icon(pass ? Icons.visibility : Icons.visibility_off),
    //                 onPressed: () {
    //                   setState(() {
    //                     pass = !pass;
    //                     print(pass);
    //                   });
    //                 },
    //               )
    //             : null,
    //         prefixIcon: Icon(widget.icon),
    //         prefixIconColor: kPrimaryColor,
    //         border:const OutlineInputBorder(),
    //         label: Text(widget.hint),
    //       ),
    //     ),
    //   ),
    // );