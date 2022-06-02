import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/My_Evaluation_screen.dart';
import 'package:gp/Info.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/shared/cubits/cubit/quiz_cubit.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Levels_View.dart';
import 'package:expandable/expandable.dart';
import 'Sidebar/BlockNavigation.dart';
import 'classes/student.dart';
class lastQuizzes extends StatefulWidget{
  final student std;
  final String courseCode;
  lastQuizzes(this.std, this.courseCode);

  @override
  State<lastQuizzes> createState() => _lastQuizzesState(std, courseCode);
}

class _lastQuizzesState extends State<lastQuizzes> {
  student std;
  String courseCode;
  _lastQuizzesState(this.std, this.courseCode);
  int _selectedIndex = 3;
  // int _selectedIndex = 2;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(INFO(std, courseCode));
    _pages.add(levels_view(std));
    _pages.add(Course_evual_categories(std, courseCode));
    _pages.add(lastQuizzes(std, courseCode));
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

  Widget build_card(Entry root, String urlImage)
  {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: ExpandablePanel(
          header: Container(
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
                                  Image(image: NetworkImage(urlImage),
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
                                      root.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
        
                                      ),
                                    ),
                                ),]),
                                  ),
          expanded: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: root.children.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: Icon(Icons.quiz, color: Colors.amber[200+index],),
                title: Text('Attempt ' +(index+1).toString()),
                onTap: (){
                  //go to result screen?
                },
              );
            }),
            collapsed: Text(''),
        ),
      ),
      
    );   
   
  }
  @override
  Widget build(BuildContext context) {
    addTOList();
    return Builder(
      builder: (context) {
        QuizCubit.get(context).getStudentQuizzes(int.parse(std.id), courseCode);
        return BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            else {
              var quizCubit = QuizCubit.get(context);
              var topicQuizzes = quizCubit.topicQuizzes;
              var levelQuizzes = quizCubit.levelQuizzes;
              List<Entry> levelEntries = prepare_level_entries(levelQuizzes);
              List<Entry> topicEntries = prepare_topic_entries(topicQuizzes);

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
                      itemCount: levelEntries.length,
                      itemBuilder: (context, index){
                        return build_card(levelEntries[index], 'https://cmkt-image-prd.freetls.fastly.net/0.1.0/ps/6151529/3005/2000/m1/fpnw/wm0/quiz-1-.jpg?1553762089&s=9b9ad3d167a8d446dd625dabd9ef4ea0');                      },
                      
                      ),
                    ListView.builder(
                      itemCount: topicEntries.length,
                      itemBuilder: (context, index){
                        return build_card(topicEntries[index], 'https://cmkt-image-prd.freetls.fastly.net/0.1.0/ps/6151529/3005/2000/m1/fpnw/wm0/quiz-1-.jpg?1553762089&s=9b9ad3d167a8d446dd625dabd9ef4ea0');
                      },
                      ),        
                  ],
                ),
              ),
            );
            }
          }
        );
      }
    );
  }
}
List<Entry> prepare_level_entries(List<Quiz_> quizzes){
  List<Entry> entries = [];
  Entry level1 = Entry("Level 1","1", []);
  Entry level2 = Entry("Level 2","2", []);
  Entry level3 = Entry("Level 3","3", []);
  Entry level4 = Entry("Level 4","4", []);
  Entry level5 = Entry("Level 5","5", []);
  for(var quiz in quizzes)
  {
    switch(quiz.level_id)
    {
      case 1:
      {
        level1.children.add(quiz);
        break;
      }
      case 2:
      {
        level2.children.add(quiz);
        break;
      }
      case 3:
      {
        level3.children.add(quiz);
        break;
      }
      case 4:
      {
        level4.children.add(quiz);
        break;
      }
      case 5:
      {
        level5.children.add(quiz);
        break;
      }
    }

  }
  entries.add(level1);
  entries.add(level2);
  entries.add(level3);
  entries.add(level4);
  entries.add(level5);
  return entries;
}
List<Entry> prepare_topic_entries(List<Quiz_> quizzes){
  List<Entry> entries = [];
  Entry topic1 = Entry("Topic 1","1", []);
  Entry topic2 = Entry("Topic 2","2", []);
  Entry topic3 = Entry("Topic 3","3", []);
  Entry topic4 = Entry("Topic 4","4", []);
  Entry topic5 = Entry("Topic 5","5", []);
  Entry topic6 = Entry("Topic 6","5", []);
  Entry topic7 = Entry("Topic 7","5", []);
  Entry topic8 = Entry("Topic 8","5", []);
  Entry topic9 = Entry("Topic 9","5", []);
  Entry topic10 = Entry("Topic 10","5", []);
  for(var quiz in quizzes)
  {
    switch(quiz.topic_id)
    {
      case 1:
      {
        topic1.children.add(quiz);
        break;
      }
      case 2:
      {
        topic2.children.add(quiz);
        break;
      }
      case 3:
      {
        topic3.children.add(quiz);
        break;
      }
      case 4:
      {
        topic4.children.add(quiz);
        break;
      }
      case 5:
      {
        topic5.children.add(quiz);
        break;
      }
      case 6:
      {
        topic6.children.add(quiz);
        break;
      }
      case 7:
      {
        topic7.children.add(quiz);
        break;
      }
      case 8:
      {
        topic8.children.add(quiz);
        break;
      }
      case 9:
      {
        topic9.children.add(quiz);
        break;
      }
      case 10:
      {
        topic10.children.add(quiz);
        break;
      }
    }

  }
  entries.add(topic1);
  entries.add(topic2);
  entries.add(topic3);
  entries.add(topic4);
  entries.add(topic5);
  entries.add(topic6);
  entries.add(topic7);
  entries.add(topic8);
  entries.add(topic9);
  entries.add(topic10);
  return entries;
}
class Entry{
  final String title;
  final String id;
  List<Quiz_> children;
  Entry(this.title, this.id, [this.children = const <Quiz_>[]]);
}
