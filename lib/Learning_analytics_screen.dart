import 'package:flutter/material.dart';
import 'package:gp/Courses_evaluations_Screen.dart';
import 'package:gp/L_types.dart';
import 'package:gp/myprofile_screen.dart';

import 'Home.dart';
import 'Types.dart';
class Learning_analytics_screen extends StatefulWidget {
  const Learning_analytics_screen({Key? key}) : super(key: key);

  @override
  _Learning_analytics_screenState createState() => _Learning_analytics_screenState();
}

class _Learning_analytics_screenState extends State<Learning_analytics_screen> {
  int _selectedIndex = 1;
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
        title:const Text("Learning Analytics"),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Home(0)));
            _selectedIndex-=1;

          },),
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
    );
  }
}
