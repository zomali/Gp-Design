import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/My_Evaluation_screen.dart';
import 'package:gp/Info.dart';
import 'package:gp/quiz_view.dart';
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

  Widget build_card(Entry root, String urlImage, Color children_color)
  {
    return Padding(
      padding: EdgeInsets.all(5.0),
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
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(.6),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.0,
        
                                    ),
        
                                    child: Text(
                                      root.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: children_color,
        
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
                leading: Icon(Icons.quiz, color: children_color,),
                title: Text('Attempt ' +(index+1).toString(), style: TextStyle(color: children_color,),),
                onTap: (){
                  String title = root.title +" Attempt " + (index+1).toString() + " Quiz";
                   Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                           QuizResults(int.parse(root.id), std,root.type, root.children[index].questions, title)
             ));
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
                  leading: Icon(Icons.quiz),
                  title: Text('Quizzes'),
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 2,
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
                        return build_card(levelEntries[index], 'https://cmkt-image-prd.freetls.fastly.net/0.1.0/ps/6151529/3005/2000/m1/fpnw/wm0/quiz-1-.jpg?1553762089&s=9b9ad3d167a8d446dd625dabd9ef4ea0', Colors.amber[300]!);                      },
                      
                      ),
                    ListView.builder(
                      itemCount: topicEntries.length,
                      itemBuilder: (context, index){
                        return build_card(topicEntries[index], 'https://cmkt-image-prd.freetls.fastly.net/0.1.0/ps/6151529/3005/2000/m1/fpnw/wm0/quiz-1-.jpg?1553762089&s=9b9ad3d167a8d446dd625dabd9ef4ea0', Colors.green[300]!);
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
  for(int i = 0; i< 5; i++)
  {
    String id = (i+1).toString();
    String type = "Level";
    String title = type +" "+ id;
    Entry level = Entry(title,id, type, []);
    entries.add(level);
  }
  for(var quiz in quizzes)
  {
    entries[quiz.level_id-1].children.add(quiz);
  }

  return entries;
}
List<Entry> prepare_topic_entries(List<Quiz_> quizzes){
  List<Entry> entries = [];
  for(int i = 0; i< 17; i++)
  {
    String id = (i+1).toString();
    String type = "Topic";
    String title = type +" "+ id;
    Entry topic = Entry(title,id, type, []);
    entries.add(topic);
  }
  for(var quiz in quizzes)
  {
    entries[quiz.topic_id-1].children.add(quiz);
  }

  return entries;
}
class Entry{
  final String title;
  final String id;
  final String type;
  List<Quiz_> children;
  Entry(this.title, this.id, this.type, [this.children = const <Quiz_>[]]);
}
