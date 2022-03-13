
import 'package:flutter/material.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Learning_analytics_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Home.dart';
import 'Types.dart';
class Courses_evaluations_Screen extends StatefulWidget {
  const Courses_evaluations_Screen({Key? key}) : super(key: key);

  @override
  _Courses_evaluations_ScreenState createState() => _Courses_evaluations_ScreenState();
}

class _Courses_evaluations_ScreenState extends State<Courses_evaluations_Screen> {
  int _selectedIndex = 2;
  static  List<Widget> _pages = <Widget>[
    Home(0),
    Learning_analytics_screen(),


    Courses_evaluations_Screen(),
    MyProfileScreen(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;


      //   print("index = ${widget.ind} ");
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>moveToPage(index)));



    },
    );
  }
  Widget moveToPage(int index){

    return _pages.elementAt(_selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (
        title:const Text("Courses Evaluation"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize:16 ,


        unselectedItemColor: Colors.grey ,
        // unselectedFontSize: 11,
        unselectedFontSize: 16,

        //    currentIndex: 0,
        items:const [
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
        // onTap: (index){
        //   print("index = ${widget.ind} ");
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context)=>moveToPage(index)));
        //
        //
        //
        // },
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,

      ),
      body: Center(
        child: (
        Column(
          children: [
            SizedBox(
              height: 30,
            ),


            Text(
              "Completed Levels ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularPercentIndicator(
              radius: 180.0,
              lineWidth: 20.0,
              animation: true,
              percent: 0.7,
              // backgroundColor: Colors.white,
              progressColor:Colors.blue ,
              center:  Text(
                "70.0%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),

              ),


              circularStrokeCap: CircularStrokeCap.round,
              // progressColor: Colors.deepOrange,
            ),
          ],
        )
        ),
      ),
    );
  }
}
