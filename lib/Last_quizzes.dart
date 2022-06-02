import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/My_Evaluation_screen.dart';
import 'package:gp/Info.dart';
import 'package:gp/view_quiz.dart';
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

  Widget build_card(Entry root, String urlImage, Color children_color)
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
                   Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                            QuizResults(int.parse(root.id), std, get_answers(root.children[index]), get_questions(root.children[index]) ,root.type)
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

Map<int,int>get_answers(Quiz_ quiz)
{
  Map<int,int> answers = new Map();
     for(var question in quiz.questions)
     {
       answers[question.id]=question.student_answer_id;

     }
     return answers;
}
List<Question_>get_questions(Quiz_ quiz)
{
  List<Question_> questions = [];
     for(var question in quiz.questions)
     {
       Question_ q = Question_();
       q.id = question.id;
       q.question = question.question;
       q.choices = question.choices;
       q.complexity = question.complexity;
       q.points = question.points;
       q.answer_id = question.answer_id;
       q.topic_id =  question.topic_id;
       questions.add(q);
     }
     return questions;
}
List<Entry> prepare_level_entries(List<Quiz_> quizzes){
  List<Entry> entries = [];
  Entry level1 = Entry("Level 1","1","Level", []);
  Entry level2 = Entry("Level 2","2","Level", []);
  Entry level3 = Entry("Level 3","3", "Level", []);
  Entry level4 = Entry("Level 4","4", "Level", []);
  Entry level5 = Entry("Level 5","5", "Level", []);
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
  Entry topic1 = Entry("Topic 1","1", "Topic", []);
  Entry topic2 = Entry("Topic 2","2","Topic", []);
  Entry topic3 = Entry("Topic 3","3","Topic", []);
  Entry topic4 = Entry("Topic 4","4","Topic", []);
  Entry topic5 = Entry("Topic 5","5","Topic", []);
  Entry topic6 = Entry("Topic 6","6","Topic", []);
  Entry topic7 = Entry("Topic 7","7","Topic", []);
  Entry topic8 = Entry("Topic 8","8","Topic", []);
  Entry topic9 = Entry("Topic 9","9","Topic", []);
  Entry topic10 = Entry("Topic 10","10","Topic", []);
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
  final String type;
  List<Quiz_> children;
  Entry(this.title, this.id, this.type, [this.children = const <Quiz_>[]]);
}
