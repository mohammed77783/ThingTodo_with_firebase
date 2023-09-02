

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_with_firebase/screen/updateTask_Rotain.dart';
import '../component/Task_and_rotian_container.dart';
import '../screen/sinup.dart';

class task_and_main_screen extends StatefulWidget {
  const task_and_main_screen({super.key});

  @override
  State<task_and_main_screen> createState() => _task_and_main_screenState();
}

class _task_and_main_screenState extends State<task_and_main_screen> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Task");
      CollectionReference RotainReference =
      FirebaseFirestore.instance.collection("Rotain");
  List Task = [];
  List doId=[]; List RotId=[];
  getTaskDate() async {
    await collectionReference
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
          value.docs.forEach((element) {setState(() {
         Task.add( element.data());
          doId.add( element.id);
          });
          print("======================================================");
          print(element.data());});
        });
  }
    List Rotaine = [];
   getRotainDate() async {
    await RotainReference
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          Rotaine.add(element.data());
            RotId.add( element.id);
        });
        print("======================================================");
        print(element.data());
      });
    });
  }

  
@override
  void initState() {
   getTaskDate();
   getRotainDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [Text("Today's Tasks")],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.sort,
                            ),
                            label: Text(
                              'Filter by',
                              style: TextStyle(fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.filter_list),
                            label:
                                Text('Sort by', style: TextStyle(fontSize: 10)),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Task",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
// Container(
//   decoration: BoxDecoration(borderRadius: ),
//   child:)
            Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                  right: Radius.circular(10),
                ),
              ),
              child: ListView.builder(
                  itemCount: Task.length,
                  itemBuilder: (context, index) {
                    return Dismissible(key: UniqueKey(),
                    onDismissed: (direction) {
                        AwesomeDialog(
                                      animType: AnimType.rightSlide,
                                      context: context,
                                      dialogType: DialogType.info,
                                    
                                    
                                      title: 'Info',
                                      desc: 'Do you want to delete this Task',
                                      btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                     await collectionReference.doc(doId[index]).delete();
                   await  FirebaseStorage.instance.refFromURL(Task[index]['imageurl']).delete();
                    },
                                )..show();
                    },
                      child: InkWell(onLongPress: (){
                                     AwesomeDialog(
                                      animType: AnimType.rightSlide,
                                      context: context,
                                      dialogType: DialogType.info,

                                      title: 'Info',
                                      desc: 'Do you want to delete this Task',
                                      btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                     await collectionReference.doc(doId[index]).delete();
                    },
                                )..show();
                                   
                    
                      },onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>update_page(userId: doId[index],sendnote: Task[index],dotype:"Task")));
                      },child: Task_and_rotian_container(title: Task[index]['title'],
                      catagor:Task[index]['catagory'] ,time:Task[index]['data_time']  ,priorit: Task[index]['priorit'],)),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Rotaine",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                  right: Radius.circular(10),
                ),
              ),
              child: ListView.builder(
                  itemCount: Rotaine.length,
                  itemBuilder: (context, index) {
                    return Dismissible(key: UniqueKey(),
                    onDismissed: (direction) {
                        AwesomeDialog(
                                      animType: AnimType.rightSlide,
                                      context: context,
                                      dialogType: DialogType.info,
                                    
                                    
                                      title: 'Info',
                                      desc: 'Do you want to delete this Task',
                                      btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                     await RotainReference.doc(RotId[index]).delete();
                   await  FirebaseStorage.instance.refFromURL(Rotaine[index]['imageurl']).delete();
                    },
                                )..show();
                    },
                      child: InkWell(onLongPress: (){
                                     AwesomeDialog(
                                      animType: AnimType.rightSlide,
                                      context: context,
                                      dialogType: DialogType.info,

                                      title: 'Info',
                                      desc: 'Do you want to delete this Task',
                                      btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                     await RotainReference.doc(RotId[index]).delete();
                    },
                                )..show();
                                   
                    
                      },onTap:(){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>update_page(userId: RotId[index],sendnote: Rotaine[index],dotype:"Task")));
                      },child: Task_and_rotian_container(title: Rotaine[index]['title'],
                      catagor:Rotaine[index]['catagory'] ,time:Rotaine[index]['data_time']  ,priorit: Rotaine[index]['priorit'],)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
