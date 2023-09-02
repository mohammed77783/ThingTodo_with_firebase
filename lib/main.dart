
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_firebase/screen/add.dart';
import 'package:todo_with_firebase/screen/updateTask_Rotain.dart';
import 'package:todo_with_firebase/screen/login.dart';
import 'package:todo_with_firebase/screen/main_secreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'constaint.dart';

bool? loginstate;
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
var user=FirebaseAuth.instance.currentUser;
if(user!=null){
  loginstate=true;
}
else{
  loginstate=false;
}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:kPrimaryColor),
        useMaterial3: true,
      ),
      home:
      loginstate==true?main_secreen(): login(),
  
    );
  }
}

