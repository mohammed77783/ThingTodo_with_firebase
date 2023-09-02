import 'dart:io';

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../constaint.dart';
class update_page extends StatefulWidget {
  var userId;
  final sendnote;
  final dotype;
   update_page({super.key,required this.userId,this.sendnote, this.dotype});

  @override
  State<update_page> createState() => _update_pageState();
}

class _update_pageState extends State<update_page> {
String? _dropDownValue;
  
  String? selectedDateTime;
  int? _selectedColor ;
  var file,file2,
      title_of_task,
      descrip,
      Catagory,
      timeandate,
      priorit,
      notification,
      imageurl;
  var ref;

  GlobalKey<FormState> form_state = new GlobalKey();
    Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
              pickedDateTime.year,
              pickedDateTime.month,
              pickedDateTime.day,
              pickedTime.hour,
              pickedTime.minute)) as String?;
        });
      }
    }
  }

 @override
 void initState() {
 selectedDateTime=widget.sendnote['data_time'];
 _dropDownValue=widget.sendnote['notificaion'];
    file=widget.sendnote['imageurl'];
   super.initState();
   
 } 


  Future<void> showsheetbottom(conte) async {
    return showModalBottomSheet(
        context: conte,
        builder: (context) {
          return Container(
            height: 150,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    "Upload from",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    file2 = File(picked.path);
                    setState(() {
                      file=File(picked.path);
                    });
                    var rad = Random().nextInt(10000);
                    var nameof_image = "$rad" + basename(picked.path);
                    ref = FirebaseStorage.instance
                        .ref('images')
                        .child("$nameof_image");
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.storage),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "form Gallery",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    file2 = File(picked.path);
                    var rad = Random().nextInt(10000);
                    var nameof_image = "$rad" + basename(picked.path);
                    ref = FirebaseStorage.instance
                        .ref('images')
                        .child("$nameof_image");
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "form camera",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              )
            ]),
          );
        });
  }
  
  editenot() async {
    var fd = form_state.currentState;
    DocumentReference db = FirebaseFirestore.instance.collection("Task").doc(widget.userId);
    if (fd!.validate()) {
      fd.save();
if(file2!=null)
{
  await ref.putFile(file2);
  imageurl = await ref.getDownloadURL();
}
      await db.update({
        "title": title_of_task,
        'description': descrip,
        'catagory': Catagory,
        "data_time": timeandate,
        'priorit': _selectedColor,
        "notificaion": notification,
        'imageurl': imageurl,
        'userId': FirebaseAuth.instance.currentUser?.uid
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: form_state,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 60,
              ),
Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text("Edit Page",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              
              //title of task or Rotain
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  initialValue:widget.sendnote['title'],
                    cursorColor: kPrimaryColor,
                    onSaved: (val) {
                      setState(() {
                        title_of_task = val;
                      });
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return "Title  can't to be larger then 100";
                      }
                      if (value!.length < 2) {
                        return "title can't to be less Two";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('title of $widget.dotype'),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        border: UnderlineInputBorder())),
              ),
              const SizedBox(
                height: 25,
              ),
              //the Radio group
              // Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const Column(
              //           children: [
              //             Text(
              //               "Select Rotain of Task",
              //               style: TextStyle(fontWeight: FontWeight.w900),
              //             ),
              //           ],
              //         ),
              //         Column(
              //           children: [
              //             Row(
              //               children: [
              //                 const Text(
              //                   "Task",
              //                   style: TextStyle(fontSize: 15),
              //                 ),
              //                 Radio(
              //                     autofocus: true,
              //                     value: "Task",
              //                     groupValue: Tsaktype,
              //                     onChanged: (value) {
              //                       setState(() {
              //                         Tsaktype = value!;
              //                       });
              //                     })
              //               ],
              //             )
              //           ],
              //         ),
              //         Column(
              //           children: [
              //             Row(
              //               children: [
              //                 const Text("Rotain",
              //                     style: TextStyle(fontSize: 15)),
              //                 Radio(
              //                     value: "Rotain",
              //                     groupValue: Tsaktype,
              //                     onChanged: (value) {
              //                       setState(() {
              //                         Tsaktype = value!;
              //                       });
              //                     })
              //               ],
              //             )
              //           ],
              //         )
              //       ],
              //     )),
               const SizedBox(
                height: 25,
              ),
              //start of description
              Container(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        initialValue:widget.sendnote['description'],
                          onSaved: (val) {
                            setState(() {
                              descrip = val;
                            });
                          },
                          validator: (value) {
                            if (value!.length > 200) {
                              return "Description  can't to be larger then 100";
                            }
                            if (value!.length < 2) {
                              return "Description can't to be less Two";
                            }
                            return null;
                          },
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 200,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              labelText: 'Description',
                              border: UnderlineInputBorder()))),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        initialValue:widget.sendnote['catagory'],
                          minLines: 1,
                          maxLines: 100,
                          onSaved: (val) {
                            setState(() {
                              Catagory = val;
                            });
                          },
                          validator: (value) {
                            if (value!.length > 100) {
                              return "Category  can't to be larger then 100";
                            }
                            if (value!.length < 2) {
                              return "Category can't to be less Two";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              labelText: 'Category',
                              border: UnderlineInputBorder()))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //select the data and time
              Container(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        
                        
                          controller: TextEditingController(
                            text: selectedDateTime != null
                                ? selectedDateTime.toString()
                                : '',
                          ),
                          readOnly: true,
                          minLines: 1,
                          maxLines: 100,
                          onSaved: (val) {
                            setState(() {
                              timeandate = val;
                            });
                          },
                          validator: (value) {
                            if (value!.length < 2) {
                              return "You must input the Date and Time";
                            }
                            return null;
                          },
                          onTap: () => _selectDateTime(context),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: kPrimaryColor)),
                            hintText: 'Pick Date & Time',
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.calendar_today_outlined,
                                color: kPrimaryColor,
                              ),
                              onPressed: () => _selectDateTime(context),
                            ),
                          ))),
                ),
              ),

              const SizedBox(
                height: 17,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Priority",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              //select the the priority
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: List<Widget>.generate(
                      4,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: index == 0
                                    ? kPrimaryColor
                                    : index == 1
                                        ? pinkClr
                                        : index == 2
                                            ? yellowClr
                                            : green,
                                child:index==_selectedColor || widget.sendnote['priorit']==index
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 14,
                                      )
                                    : null,
                              ),
                            ),
                          )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //select when start notifiction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                 
                  readOnly: true,
                  onSaved: (val) {
                    setState(() {
                      notification = val;
                    });
                  },
                  validator: (value) {
                    if (value!.length < 2) {
                      return "Notification  can't to be without value";
                    }
                    return null;
                  },
                  controller: TextEditingController(
                      text: _dropDownValue != null ? _dropDownValue : ""),
                  decoration: InputDecoration(
                    labelText: 'Notification',
                    suffixIcon: DropdownButton(
                      items: [
                        '5 minutes Before',
                        '10 minutes Before',
                        '15 minutes Before',
                        '20 minutes Before'
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _dropDownValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                 
                    controller: TextEditingController(
                      text: file != null ? file.toString() : '',
                    ),
                    readOnly: true,
                    minLines: 1,
                    maxLines: 100,
                    onTap: () => showsheetbottom(context),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      hintText: 'Seclect file to upload',
                      border: UnderlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.file_present_rounded,
                          color: kPrimaryColor,
                        ),
                        onPressed: () => showsheetbottom(context),
                      ),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              //add button
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () async {
                  
                      await editenot();
                      Navigator.of(context).pop();
                    },
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    minWidth: MediaQuery.of(context).size.width - 36 * 2,
                    color: kPrimaryColor,
                    child: Text(
                      "Update",
                      style: TextStyle(color: kprimaryLightColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
 
  }
  

}