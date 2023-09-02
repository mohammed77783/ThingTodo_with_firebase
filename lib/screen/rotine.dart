import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/Task_and_rotian_container.dart';

class rotine_screen extends StatefulWidget {
  const rotine_screen({super.key});

  @override
  State<rotine_screen> createState() => _rotine_screenState();
}

class _rotine_screenState extends State<rotine_screen> {
  CollectionReference RotainReference =
      FirebaseFirestore.instance.collection("Rotain");
  List Rotaine = [];
  getRotainDate() async {
    await RotainReference
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Rotaine.add(element.data());
        });
        print("======================================================");
        print(element.data());
      });
    });
  }

  @override
  void initState() {
    getRotainDate();
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
              itemCount: Rotaine.length,
              itemBuilder: (context, index) {
                return InkWell(
                    child: Task_and_rotian_container(
                  title: Rotaine[index]['title'],
                  catagor: Rotaine[index]['catagory'],
                  time: Rotaine[index]['data_time'],
                  priorit: Rotaine[index]['priorit'],
                ));
              })
        ]),
      ),
    );
  }
}
