import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Home.dart';
import 'Learning_analytics_screen.dart';
import 'Levels_View.dart';
import 'classes/student.dart';
import 'myprofile_screen.dart';

class Dashboard_screen extends StatefulWidget {
 // const Dashboard_screen({Key? key}) : super(key: key);
  final student std;
  Dashboard_screen(this.std);
  @override
  State<Dashboard_screen> createState() => _Dashboard_screenState(std);
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  int _selectedIndex = 3;
  final student std;
  _Dashboard_screenState(this.std);

  // int _selectedIndex = 2;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(levels_view(std));
    _pages.add(Learning_analytics_screen(std));
    _pages.add(Course_evual_categories(std, "CSW150"));
    _pages.add(Dashboard_screen(std));
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Dashboard"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home(std)));
            _selectedIndex -= 3;
          },
        ),
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
