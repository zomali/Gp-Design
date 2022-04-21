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
    _pages.add(levels_view(std, courseCode));
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
  Widget _outcomes(@required Color color, @required String title){
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    ),

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
                                          color: Colors.grey[350],
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
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        "Learning Outcomes",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        top: 20,
                        right: 10,
                      ), //outcomes
                      child: ListView.builder(
                        itemCount: course.learning_outcomes.length,
                        itemBuilder: (BuildContext context,int index){
                          return GestureDetector(
                            onTap:(){},
                            child: Card(
                              child: _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[index]),
                            //  child: padding:const EdgeInsets.only(bottom: 10,),
                          
                          ),);
                        },                        
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 30),
                      child: Text(
                        "Instructors",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        top: 20,
                        right: 10,
                      ), //outcomes
                      child: Column(
                        children: [
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[0]),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[1]),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[2]),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[3]),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[4]),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[5]),
                         const Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                          _outcomes(Theme.of(context).colorScheme.secondary,
                              course.learning_outcomes[6]),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 30),
                      child: Text(
                        "Instructors",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          top: 30,
                        ),
                        child: Row(
                          children: [
                            _selectedCleaning(
                                Theme.of(context).colorScheme.secondary,
                                course.instructors[0].name,
                                course.instructors[0].contact),
                            _selectedCleaning(
                                Theme.of(context).colorScheme.secondary,
                                course.instructors[1].name,
                                course.instructors[1].contact),
                            _selectedCleaning(
                                Theme.of(context).colorScheme.secondary,
                                course.instructors[2].name,
                                course.instructors[2].contact)
                          ],
                        ),
                      ),
                    ), //instructors
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
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