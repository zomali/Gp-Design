import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/Info.dart';
import 'package:gp/Sidebar/BlockNavigation.dart';
import 'package:gp/Topic_view.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'package:gp/shared/cubits/cubit/level_cubit.dart';
import 'package:gp/classes/student.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Dashboard_screen.dart';
import 'Home.dart';
import 'Last_quizes.dart';
import 'Learning_analytics_screen.dart';
import 'myprofile_screen.dart';

class levels_view extends StatefulWidget with NavigationStates {
  final student std;
  final String courseCode;
  levels_view(this.std, this.courseCode);
  @override
  _levels_view createState() => _levels_view(std, courseCode);
}

class _levels_view extends State<levels_view> {
  student std;
  String courseCode;
  _levels_view(this.std, this.courseCode);
  int _selectedIndex = 1;
  static List<Widget> _pages = <Widget>[];
  void addTOList() {
    _pages.add(INFO(std, courseCode));
    _pages.add(levels_view(std, courseCode));
    _pages.add(Course_evual_categories(std, courseCode));
    _pages.add(lastQuizes(std, courseCode));
  }

  void _onItemTapped(int index) {
    setState(
          () {

        _selectedIndex = index;

        //   print("index = ${widget.ind} ");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>moveToPage(_selectedIndex) ));
      },
    );
  }

  Widget moveToPage(int index) {
    //Widget page = _pages.elementAt(_selectedIndex);
    //page(std);
    _selectedIndex%=4;
    return _pages.elementAt(_selectedIndex);
  }

  set value(String? value) {}

  Widget putIcon(index) {
    if ((std.level - 1) < index) {
      return const Icon(Icons.lock);
    } else {
      return const Icon(Icons.lock_open);
    }
  }

  @override
  Widget build(BuildContext context) {
    addTOList();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    var course_name = "Structured Programming";
    List<int> levelIDs = [1, 2, 3, 4, 5];
    return Scaffold(
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
        backgroundColor: Colors.white,
        body: Builder(builder: (context) {
          LevelCubit.get(context).getAllLevels(levelIDs);
          return BlocBuilder<LevelCubit, LevelState>(builder: (context, state) {
            if (state is LevelLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              var levelCubit = LevelCubit.get(context);
              var levelsList = levelCubit.allLevels;
              return Column(children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    color: Colors.blue,
                  ),
                  child: Stack(children: [
                    Positioned(
                        top: 30,
                        left: 0,
                        child: Container(
                          height: 50,
                          width: 310,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              )),
                        )),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: Row(children: [
                        Icon(Icons.list,color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text(
                          course_name,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      ]),
                    )
                  ]),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: levelsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              //action on tap
                              if (levelsList[index].id <=
                                  std.courses['CSW150']['current_level']) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        topic_view(std, levelsList[index])));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Unlock this level first to view it",
                                );
                              }
                            },
                            child: Card(
                              child: Row(children: <Widget>[
                                putIcon(index),
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  height: 120,
                                  width: width * 0.9,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(80.0)),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          offset: new Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 22, top: 20.0, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Level " +
                                              levelsList[index].id.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          levelsList[index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "Number of Topics: " +
                                              levelsList[index]
                                                  .topics
                                                  .length
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ));
                      },
                    ),
                  ),
                )
              ]);
            }
          });
        }));
  }
}
