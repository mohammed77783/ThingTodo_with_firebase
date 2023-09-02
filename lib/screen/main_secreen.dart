import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../component/SearchBar.dart';
import '../constaint.dart';
import '../main.dart';
import '../screen/add.dart';
import '../screen/rotine.dart';
import '../screen/setting.dart';
import '../screen/task.dart';
import '../screen/task_and_main_screen.dart';
class main_secreen extends StatefulWidget {
  const main_secreen({super.key});

  @override
  State<main_secreen> createState() => _main_secreenState();
}

class _main_secreenState extends State<main_secreen> {
  List l = const[
    ['andy-beales-53407-unsplash@2x.png', 'journey', 'Fitness'],
    ['scott-warman-525481-unsplash@2x.png', 'Grocery', 'list'],
    [
      'natalya-zaritskaya-144626-unsplash@2x.png',
      'Family',
      'plan'
    ],
    ['jacek-dylag-782819-unsplash@2x.png', 'Shopping', 'List']
  ];
  int selected_index = 0;
  List page = [
    task_and_main_screen(),
    task_screen,
    task_screen(),
    rotine_screen(),
    setting_screen()
  ];

//this function to get user who login to app from firebase auth
  getuser(){
    var user=FirebaseAuth.instance.currentUser;
    print(user);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryLightColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 8),
              expandedTitleScale: 1.0,
              title: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(child: SearchBa_r()),
                      SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: l.length,
                            itemBuilder: ((context, index) {
                       
                              return Padding(
                                padding: EdgeInsets.only(left: 8),
                                child:  Container(
                                  width: 100,
                                  height: 130,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      width: 90,
                                      margin: EdgeInsets.only(top: 50),
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFFFF),
                                            Color(0xFFFAFAFA),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Container(
                                           margin:EdgeInsets.only(left: 10,top: 4),
                                  
                                        child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [ const Text(
                                              'Set a',
                                              style: TextStyle(
                                                  fontSize: 10, color: Colors.black),
                                            ),
                                           Text(
                                              l[index][1],
                                              style:const  TextStyle(
                                                  fontSize: 15, color:kPrimaryColor),
                                            ),
                                             Text(
                                              l[index][2],
                                              style:const TextStyle(
                                                  fontSize: 15, color:kPrimaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                          
                          )
                    ]),
              ),
              background: Image.asset(
                "assets/images/sliverx2.png",
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
        body: page.elementAt(selected_index),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFFAFAFA),
          currentIndex: selected_index,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedItemColor: kPrimaryColor,
          onTap: (value) => setState(() {
            if(value==1)return;
            selected_index = value;
          }),
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
return add_screen();
                 }
                 
                 ));
                
              }, icon: Icon(Icons.add_task)),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task),
              label: 'rotain',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'setting',
            ),
          ],
        ),
      ),
      
    );
    
  }
}
