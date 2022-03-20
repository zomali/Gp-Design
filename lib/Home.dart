import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp/Courses_evaluations_Screen.dart';
import 'package:gp/Learning_analytics_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'L_types.dart';
import 'Levels.dart';
import 'Types.dart';
//import 'package:flutter_application_1/levels.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'classes/student.dart';

class Home extends StatefulWidget {
  final student std;
  Home(this.std);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(widget.std),
    );
  }
}

class HomePage extends StatefulWidget {
  final student std;
  HomePage(this.std);

  @override
  _HomePageState createState() => _HomePageState(std);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  student std;
  _HomePageState(this.std);
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(Home(std));
    _pages.add(Learning_analytics_screen(std));
    _pages.add(Courses_evaluations_Screen(std));
    _pages.add(MyProfileScreen(std));
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;

        //   print("index = ${widget.ind} ");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => moveToPage(index)));
      },
    );
  }

  Widget moveToPage(int index) {
    //Widget page = _pages.elementAt(_selectedIndex);
    //page(std);
    return _pages.elementAt(_selectedIndex);
  }

  Widget _selectedCleaning(@required Color color, @required String title,
      @required String supTitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(
        left: 20,
      ),
      height: 120,
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            supTitle,
            style: const TextStyle(fontSize: 19, color: Colors.white70),
          )
        ],
      ),
    );
  }

  Widget _selectedSPImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(
        left: 10,
      ),
      height: 220,
      width: 440,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('proj_images/login_image.jpeg'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Widget _outcomes(@required Color color, @required String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(left: 20),
      height: 40,
      width: 440,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    addTOList();
    return Material(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text("Personalized E-learning System"),
          leading: const Icon(Icons.home),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,

          selectedItemColor: Colors.blue,
          selectedFontSize: 16,

          unselectedItemColor: Colors.grey,
          // unselectedFontSize: 11,
          unselectedFontSize: 16,

          //    currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              //backgroundColor: Colors.blue,
              //   backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              //  icon: Icon(Icons.up),
              label: 'Analytics',

              // backgroundColor: Colors.blue,
              //     backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer_outlined),
              label: 'Evaluation',
              //  backgroundColor: Colors.blue
              //    backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Dashboard',
              //   backgroundColor: Colors.blue
              //     backgroundColor: Colors.blue,
            )
          ],

          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, top: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('proj_images/me.jpg'),
                        ), //image
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "Hi," + std.name.toString().split(" ").first,
                              style: TextStyle(
                                letterSpacing: 2,

                                fontSize: 25,
                                //   color : Colors.blue[600],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                                // fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Level:- "+std.level.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                //       color : Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Spacer(flex: 5,),

                        Container(
                          width: 125,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('proj_images/fcis.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ), //image
                        Spacer(),
                      ],
                    ), //info
                   //info
                ), //info
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                  child: Text(
                    'Courses',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ), //course word




                Container(
                  //  height: 130,
                  margin: EdgeInsets.all(20),
                  child:  Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Levels(1))),
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            width: 130,
                            // height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                color: Colors.black12,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                ),
                              ],
                              // gradient: const LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   colors: [
                              //     Colors.grey,
                              //     Colors.white,
                              //   ],
                              // ),
                            ),
                            //  height:150,
                            //  width: 100,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('proj_images/cc.png'),
                                ), //sp image
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8),
                                  child: Text(
                                    'SP',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ), //sp word
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 2,),
                        GestureDetector(
                          onTap: () => {
                            Fluttertoast.showToast(
                                msg: "The Course Will Be Added Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                //    gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                // backgroundColor: Colors.blue[300],
                                textColor: Colors.white,
                                fontSize: 16.0),
                          },
                          child: Container(
                            width: 130,
                            // height: 160,
                            decoration: BoxDecoration(
                              //color: Colors.white70,
                              border: Border.all(
                                color: Colors.black12,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                ),
                              ],
                              // gradient: const LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   colors: [
                              //     Colors.grey,
                              //     Colors.white,
                              //   ],
                              // ),
                            ),
                            //  height:150,
                            //  width: 100,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('proj_images/m.jpg'),
                                ), //sp image
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8),
                                  child: Text(
                                    'Math 2',
                                    style: TextStyle(
                                      fontSize: 27,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ), //sp word
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 5,),                      ],
                    ),
                  ),

                Container(
                  //  height: 130,
                  margin: EdgeInsets.all(20),
                  child: Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () => {
                            Fluttertoast.showToast(
                                msg: "The Course Will Be Added Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                //    gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,

                                // backgroundColor: Colors.blue[300],
                                textColor: Colors.white,
                                fontSize: 16.0),
                          },
                          child: Container(
                            width: 130,
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            // height: 160,
                            decoration: BoxDecoration(
                              //    color: Colors.white70,
                              border: Border.all(
                                color: Colors.black12,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                ),
                              ],
                              // gradient: const LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   colors: [
                              //     Colors.grey,
                              //     Colors.white,
                              //   ],
                              // ),
                            ),
                            //  height:150,
                            //  width: 100,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('proj_images/p.png'),
                                ), //sp image
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8),
                                  child: Text(
                                    'Physics 2',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ), //sp word
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 2,),
                        GestureDetector(
                          onTap: () => {
                            Fluttertoast.showToast(
                                msg: "The Course Will Be Added Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                //    gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                // backgroundColor: Colors.blue[300],
                                textColor: Colors.white,
                                fontSize: 16.0),
                          },
                          child: Container(
                            width: 130,
                            // height: 160,
                            decoration: BoxDecoration(
                              //   color: Colors.white70,
                              border: Border.all(
                                color: Colors.black12,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 5.0,
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('proj_images/en.jpg'),
                                ), //sp image
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8),
                                  child: Text(
                                    'English 2',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ), //sp word
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex:5,),
                      ],
                    ),
                  ),

                Container(
                  //  height: 130,
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () => {
                          Fluttertoast.showToast(
                              msg: "The Course Will Be Added Soon",
                              toastLength: Toast.LENGTH_SHORT,
                              //    gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              // backgroundColor: Colors.blue[300],
                              textColor: Colors.white,
                              fontSize: 16.0),
                        },
                        child: Container(
                          width: 130,
                          // height: 160,
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            //  color: Colors.white70,
                            border: Border.all(
                              color: Colors.black12,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              ),
                            ],
                            // gradient: const LinearGradient(
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            //   colors: [
                            //     Colors.grey,
                            //     Colors.white,
                            //   ],
                            // ),
                          ),
                          //  height:150,
                          //  width: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('proj_images/electronics.png'),
                              ), //sp image
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.2, bottom: 8),
                                child: Text(
                                  'Electronics',
                                  style: TextStyle(
                                    fontSize: 23.8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ), //sp word
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 2,),
                      GestureDetector(
                        onTap: () => {
                          Fluttertoast.showToast(
                              msg: "The Course Will Be Added Soon",
                              toastLength: Toast.LENGTH_SHORT,
                              //    gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              // backgroundColor: Colors.blue[300],
                              textColor: Colors.white,
                              fontSize: 16.0),
                        },
                        child: Container(
                          width: 130,
                          // height: 160,
                          decoration: BoxDecoration(
                            //       color: Colors.white70,
                            border: Border.all(
                              color: Colors.black12,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                                spreadRadius: 5.0,
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('proj_images/business.jpg'),
                              ), //sp image
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 6.0, bottom: 8),
                                child: Text(
                                  'Business M',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ), //sp word
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 5,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
