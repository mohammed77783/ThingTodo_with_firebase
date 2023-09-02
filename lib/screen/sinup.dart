import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:todo_with_firebase/screen/main_secreen.dart';

import '../component/RoundButton.dart';
import '../component/or_divider.dart';
import '../component/showdialoge.dart';
import '../component/social_media.dart';
import '../constaint.dart';
import '../screen/login.dart';

class sinup extends StatefulWidget {
  const sinup({super.key});

  @override
  State<sinup> createState() => _sinupState();
}

class _sinupState extends State<sinup> {
  var scure_state = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey();
  var myemaail, mypsssword, myusername;

  sinupfunction() async {
    var formate = formstate.currentState;
    if (formate!.validate()) {
      formate.save();
      try {
        showloading(context);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myemaail,
          password: mypsssword,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: 'error',
                  body: Text('The password provided is too weak.'))
              .show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: 'error',
                  body: Text('The account already exists for that email.'))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFFFF),
      body: Center(
          child: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset("assets/images/Logo.jpg"),
            ),
            const SizedBox(
              height: 45,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  child: TextFormField(
                    validator: (val) {
                      if (val!.length > 100) {
                        return "Username can't to be larger then 100";
                      }
                      if (val.length < 2) {
                        return "Username can't to be less Two";
                      }
                      return null;
                    },
                    cursorColor: kPrimaryColor,
                    onSaved: (val) {
                      myusername = val!;
                    },
                    decoration:const InputDecoration(
                      focusColor: kPrimaryColor,
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: kPrimaryColor,
                      border:  OutlineInputBorder(),
                      label: Text("Enter the User Name "),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
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
                      if (value.length < 2) {
                        return "Email can't to be less Two";
                      }
                      return null;
                    },
                    cursorColor: kPrimaryColor,
                    decoration:const InputDecoration(
                      focusColor: kPrimaryColor,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: kPrimaryColor,
                      border:  OutlineInputBorder(),
                      label: Text("Enter the  email"),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
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
                      if (value.length < 2) {
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
                      label: Text("Enter the Password"),
                    ),
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            RoundButton(
                text: "Register Now",
                press: () async {
                  final respose = await sinupfunction();
                  if (respose != null) {
                    await FirebaseFirestore.instance.collection("user").add({
                      "username ": myusername,
                      "email": myemaail,
                      "password": mypsssword
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return main_secreen();
                    }));
                  } else {
                    AwesomeDialog(
                        context: context,
                        title: 'Error',
                        body: Text("there is problem with sinup"));
                  }
                },
                textColor: kprimaryLightColor,
                color: kPrimaryColor),
            const SizedBox(
              height: 10,
            ),
            divider(),
            const SizedBox(
              height: 15,
            ),
            social_media(),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return login();
                      }));
                    },
                    child: const Text(
                      ' Sign In',
                      style: TextStyle(fontSize: 15.0, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ]),
        ),
      )),
    );
  }
}
