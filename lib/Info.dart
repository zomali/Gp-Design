import 'package:flutter/material.dart';
import 'package:gp/Sidebar/BlockNavigation.dart';
import 'package:gp/login_screen.dart';

import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Last_quizes.dart';
import 'Levels_View.dart';
import 'classes/student.dart';
class INFO extends StatefulWidget with NavigationStates {
  final student std;
  INFO(this.std);
  @override
  State<INFO> createState() => _INFOState(this.std);
}

class _INFOState extends State<INFO> {


   student std;
  _INFOState(this.std);
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(INFO(std));
    _pages.add(levels_view(std));
    _pages.add(Course_evual_categories(std));
    _pages.add(lastQuizes(std));
  }

  void _onItemTapped(int index) {
    setState(
          () {

        _selectedIndex = index;
        // _selectedIndex%=3;

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
        backgroundColor: Colors.blue[600],
        title: Text('Info '),
        leading: const Icon(Icons.info),
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
            icon: Icon(Icons.list),
            //  icon: Icon(Icons.up),
            label: 'Levels',

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
            icon: Icon(Icons.newspaper),
            label: 'Quizzes',
            //   backgroundColor: Colors.blue
            //     backgroundColor: Colors.blue,
          )
        ],

        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      body: Padding(

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text('Course by DR.Sallly Saad' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),
            SizedBox(height: 10.0,),
            Text('TA: DR.ss' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),
            SizedBox(height: 10.0,),
            Text('TA: DR.vv' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),

          ],


        ),
      ),
    );
  }
}