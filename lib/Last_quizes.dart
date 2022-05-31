import 'package:flutter/material.dart';
import 'package:gp/Info.dart';
import 'package:gp/classes/classes.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Learning_analytics_screen.dart';
import 'Levels_View.dart';
import 'Sidebar/BlockNavigation.dart';
import 'classes/student.dart';
class lastQuizes extends StatefulWidget{
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
    int countOfLevels = 5;
    int countOfTopics = 7;
    int vv = 0;
    int vvv = 0;
    addTOList();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Quizzes'),
          bottom: TabBar(

            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.keyboard_double_arrow_up),text: 'Levels Quizzes'),
              Tab(icon: Icon(Icons.topic),text: 'Topics Quizzes'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,

          selectedItemColor: Colors.blue,
          selectedFontSize: 18,

          unselectedItemColor: Colors.grey,
          unselectedFontSize: 16,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_double_arrow_up),
              label: 'Levels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer_outlined),
              label: 'Evaluation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'Quizzes',
            )
          ],

          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
        body: TabBarView(
          children: [
           ListView.builder(

             itemCount: countOfLevels,
             itemBuilder: (context, index) {
               if(vv == countOfLevels)
               {
                 vv = 0;
               }
               vv++;


               return GestureDetector(

               onTap: ()
             {

               print('clicked');},
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

                           'Level $vv',
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

             );

             },

           ),
            ListView.builder(

              itemCount: countOfTopics,
              itemBuilder: (context, index) {
                if(vvv == countOfTopics)
                {
                  vvv = 0;
                }
                vvv++;
                return GestureDetector(

                  onTap: ()
                  {
                    print('clicked');},
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
                          Image(image: NetworkImage('https://media.istockphoto.com/photos/abstract-background-wallpaper-picture-id952039286?k=20&m=952039286&s=612x612&w=0&h=sTcINLuW0VnUx1tGNiJsqZnEMauIjdYXsmy4DJZEqmo='),
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

                              'topic $vvv',
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

                );

              },

            ),


          ],
        ),



      ),
    );
  }
}