// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constaint.dart';

class Task_and_rotian_container extends StatefulWidget {
  String? title, catagor, time;
  int? priorit;
  Task_and_rotian_container({
    Key? key,
    this.title,
    this.catagor,
    this.time,
    this.priorit,
  }) : super(key: key);

  @override
  State<Task_and_rotian_container> createState() =>
      _Task_and_rotian_containerState();
}

class _Task_and_rotian_containerState extends State<Task_and_rotian_container> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          margin: EdgeInsets.only(bottom: 10),
          elevation: 3,
          shadowColor: const Color(0xff2da9ef),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('hh:mm')
                        .format(DateTime.parse("${widget.time}"))),
                    Text(
                      int.parse(DateFormat('hh:mm')
                                  .format(DateTime.parse("${widget.time}"))
                                  .substring(0, 2) ) <
                              12
                          ? "AM"
                          : "PM",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("${widget.catagor}"))
                  ],
                ),
                Container(
                  padding:  EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: 
                      widget.priorit == 0
                                    ? kPrimaryColor
                                    : widget.priorit  == 1
                                        ? pinkClr
                                        : widget.priorit  == 2
                                            ? yellowClr
                                            : green),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
