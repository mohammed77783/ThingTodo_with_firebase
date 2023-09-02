import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/Task_and_rotian_container.dart';

class task_screen extends StatefulWidget {
  const task_screen({super.key});

  @override
  State<task_screen> createState() => _task_screenState();
}

class _task_screenState extends State<task_screen> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Task");
  List Task = [];
  getTaskDate() async {
    await collectionReference
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Task.add(element.data());
        });
        print("======================================================");
        print(element.data());
      });
    });
  }
   
   @override
  void initState() {
   getTaskDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
 
          
          ListView.builder(
              scrollDirection: Axis.vertical,
        shrinkWrap: true,
              itemCount: Task.length,
              itemBuilder: (context, index) {
                return InkWell(
                    child: Task_and_rotian_container(
                  title: Task[index]['title'],
                  catagor: Task[index]['catagory'],
                  time: Task[index]['data_time'],
                  priorit: Task[index]['priorit'],
                ));
              })
        ]),
      ),
    );
  }
}
