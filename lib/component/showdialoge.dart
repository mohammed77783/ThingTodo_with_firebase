  import 'package:flutter/material.dart';

showloading(context){
return showDialog(context: context, builder: (builder){
  return AlertDialog(title: Text("Please Wait"),content:
   Container(height: 50,child: Center(child:CircularProgressIndicator() ,),),);
});
  }

  