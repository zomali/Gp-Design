import 'package:flutter/material.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Learning_analytics_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Home.dart';
import 'classes/student.dart';

class Courses_evaluations_Screen extends StatefulWidget {
  final student std;
  Courses_evaluations_Screen(this.std);

  @override
  _Courses_evaluations_ScreenState createState() =>
      _Courses_evaluations_ScreenState(std);
}

class _Courses_evaluations_ScreenState
    extends State<Courses_evaluations_Screen> {
  final student std;
  _Courses_evaluations_ScreenState(this.std);
  int _selectedIndex = 2;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(Home(std));
  //  _pages.add(Learning_analytics_screen(std));
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
    return _pages.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    addTOList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses Evaluation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home(std)));
            _selectedIndex -= 2;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue[800],
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
        child: (Column(
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
              percent: 0.4,
              // backgroundColor: Colors.white,
              animationDuration: 3000,
              progressColor: Color(0xFF1565C0),
              center: Text(
                "40%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),

              circularStrokeCap: CircularStrokeCap.round,
              // progressColor: Colors.deepOrange,
            ),
          ],
        )),
      ),
    );
  }
}
