import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Sidebar/BlockNavigation.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Last_quizes.dart';
import 'Levels_View.dart';
import 'package:gp/classes/classes.dart';
import 'classes/student.dart';
class INFO extends StatefulWidget with NavigationStates {
  final student std;
  final String courseCode;
  INFO(this.std, this.courseCode);
  @override
  State<INFO> createState() => _INFOState(std, courseCode);
}

class _INFOState extends State<INFO> {
   student std;
   String courseCode;
  _INFOState(this.std, this.courseCode);
  int _selectedIndex = 0;
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
 Widget _selectedCleaning(@required Color color, @required String title, @required String supTitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(
        left: 20,
      ),
      height: 140,
      width: 280,
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
            style: const TextStyle(fontSize: 17, color: Colors.white70),
          )
        ],
      ),
    );
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
      body: Builder(
        builder: (context) {
          CourseCubit.get(context).getCourseData(courseCode);
          return BlocBuilder<CourseCubit, CourseState>(
            builder: (context, state) {
              if (state is CourseLoading){
               return Center(child: CircularProgressIndicator());
              }
              else{
                var courseCubit = CourseCubit.get(context);
                var course = courseCubit.course;
                return Container(
                height: 800,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  course.code,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: VerticalDivider(
                                    color: Colors.grey[200],
                                    width: 20,
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ),
                                Text(
                                  course.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    top: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'This course has ' +
                                         course.levels.length.toString() +
                                         ' levels', //course code
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10.0, bottom: 20)),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: new Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(color: Colors.grey, height: 30, thickness: 2,),)),
                          Text("Instructors",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,),),
                          Expanded(
                            child: new Container(
                              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Divider(color: Colors.grey, height: 30, thickness: 2,),)),
                        ],
                      ),
                    ),

                     Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          top: 10,
                        ),
                        child: Container(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: course.instructors.length,
                            itemBuilder: (BuildContext context, int index){
                              return _selectedCleaning(
                                Theme.of(context).colorScheme.secondary,
                                course.instructors[index].name,
                                course.instructors[index].contact);
                            },
                          ),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 30,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: new Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(color: Colors.grey, height: 30, thickness: 2,),)),
                          Text("Learning Outcomes",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,),),
                          Expanded(
                            child: new Container(
                              margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Divider(color: Colors.grey, height: 30, thickness: 2,),)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        top: 10,
                        right: 10,
                      ), 
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: course.learning_outcomes.length,
                          itemBuilder: (BuildContext context, int index){
                            return Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.blue),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                      border: new Border(
                                        right: new BorderSide(width: 1.0, color: Colors.white24))),
                                        child: Icon(Icons.checklist_rounded, color: Colors.white),),
                                        title: Text(
                                          course.learning_outcomes[index],
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),
                                          ),
                                        ),
                        );}
                                ),
                              ),
                            ),
                  ],
                ),
              );
              }
            },
          );
        }
      ),
    );
  }
}