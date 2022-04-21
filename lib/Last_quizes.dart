import 'package:flutter/material.dart';
import 'package:gp/Info.dart';
import 'package:gp/classes/classes.dart';

import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Learning_analytics_screen.dart';
import 'Levels_View.dart';
import 'Sidebar/BlockNavigation.dart';
import 'classes/student.dart';
class lastQuizes extends StatefulWidget with NavigationStates{
  final student std;
  final String courseCode;
  lastQuizes(this.std, this.courseCode);

  @override
  State<lastQuizes> createState() => _lastQuizesState(std, courseCode);
}

class _lastQuizesState extends State<lastQuizes> {

  student std;
  String courseCode;
  _lastQuizesState(this.std, this.courseCode);
  int _selectedIndex = 3;
  // int _selectedIndex = 2;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(INFO(std, courseCode));
    _pages.add(levels_view(std));
    _pages.add(Course_evual_categories(std, courseCode));
    _pages.add(lastQuizes(std, courseCode));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quizzes History"),
        leading: Icon(Icons.newspaper),
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
      body: SingleChildScrollView(
        child: Column(

          children: [
            GestureDetector(
              onTap: (){print('clicked 1');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The First Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 2');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Second Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 3 ');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Third Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 4');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Fourth Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 5');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'The Fifth Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],

        ),
      ),




    );
  }
}