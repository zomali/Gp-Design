import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gp/L_types.dart';
import 'package:gp/classes/student.dart';
import '../classes/classes.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
/*void main() {
  runApp(Start_Level_Quiz());
}

class Start_Level_Quiz extends StatelessWidget {
  late final Level_ level;
  Map<int,int> student_answered={};
  List<int> weakness_topic=[];
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(0," ",weakness_topic),
      home:  WelcomeScreen(0,"level",weakness_topic),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen(0,"level",weakness_topic)),
        GetPage(name: QuizScreen.routeName, p`age: () =>  QuizScreen(0,"level",weakness_topic)),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen(0,student_answered)),
      ],
    );
  }
}*/
class WelcomeScreen extends StatefulWidget {
  final int id;
  final student std;
  String stat;
  List<TopicOfWeakness_>weakness_topic;
  List<Question_>questions;
  WelcomeScreen(this.id, this.std,this.stat,this.weakness_topic,this.questions);
  static const routeName = '/welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState(id,std,stat,weakness_topic,questions);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int id;
  final student std;
  String stat;
  List<TopicOfWeakness_>weakness_topic=[];
  List<Question_>questions;
  _WelcomeScreenState(this.id,this.std,this.stat,this.weakness_topic,this.questions);
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context,id,stat,weakness_topics) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuizController>().startTimer();
    Get.lazyPut(()=>QuizController(id,std, stat,weakness_topic,questions));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'proj_images/Ain_Shams_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ), //image
                  Spacer(),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('proj_images/faculty_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ), //image
                ]
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('proj_images/quiz.png',
                width: 800,
                height: 200,),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
                child:Column(
                  children: [
                    Text(
                      stat+" "+(id).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "-The quiz consists of "+get_questions_len(stat, weakness_topic.length, id)+" questions. \n-Time of quiz is 15 minutes.\n-Read the question carefully before answering.\n-The quiz was created by Dr. Sally Saad and Dr. Salsabil Amin.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )

            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Center(
                child: RawMaterialButton(
                  onPressed: () {
                    _submit(context,id,stat,weakness_topic);
                  },
                  shape: const StadiumBorder(),
                  fillColor: Colors.blue,
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      "Start the Quizz",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: GetBuilder<QuizController>(
                init: Get.find<QuizController>(),
                builder: (controller) => Row(),
              ),)
          ],
        ),
      ),
    );
  }
}
String get_questions_len(String stat,int len,int level)
{
  int count=0;
  if(stat=="Topic")
    {
      return "10";
    }
  else if(stat=="Level")
    {
      if(level==1)
        {
          if(len==1)
            {
              count=(2*3)+(4);
            }
          else if(len==2)
            {
              count=(2*4)+3;
            }
          else if(len==3)
          {
            count=3*4;
          }
        }
      else if(level==2)
        {
          if(len==1)
          {
            count=(2*3)+(4);
          }
          else if(len==2)
          {
            count=(2*4)+3;
          }
          else if(len==3)
          {
            count=3*4;
          }
        }
      else if(level==3)
      {
        if(len==1)
        {
          count=(2*3)+(4);
        }
        else if(len==2)
        {
          count=(2*4)+3;
        }
        else if(len==3)
        {
          count=(3*4)+3;
        }
        else if(len==4)
        {
          count=4*4;
        }
      }
      else if(level==4)
      {
        if(len==1)
        {
          count=(2*3)+(4);
        }
        else if(len==2)
        {
          count=(2*4)+3;
        }
        else if(len==3)
        {
          count=3*4;
        }
      }
      else if(level==4)
      {
        if(len==1)
        {
          count=(2*3)+(4);
        }
        else if(len==2)
        {
          count=(2*4)+3;
        }
        else if(len==3)
        {
          count=(3*4)+3;
        }
        else if(len==4)
        {
          count=4*4;
        }
      }
    }
  return count.toString();
}
