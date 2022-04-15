import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gp/L_types.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
void main() {
  runApp(Start_Level_Quiz());
}

class Start_Level_Quiz extends StatelessWidget {
  Map<int,int> student_answered={};
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      home:  WelcomeScreen("2"),
      getPages: [
        GetPage(name: WelcomeScreen.routeName, page: () => WelcomeScreen("2")),
        GetPage(name: QuizScreen.routeName, page: () =>  QuizScreen("2")),
        GetPage(name: ResultScreen.routeName, page: () =>  ResultScreen(1,student_answered)),
      ],
    );
  }
}
class WelcomeScreen extends StatefulWidget {
  final String level;
  WelcomeScreen(this.level);
  static const routeName = '/welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState(level);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String level;
  _WelcomeScreenState(this.level);
  final _nameController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context) {
    FocusScope.of(context).unfocus();
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuizController>().startTimer();
    Get.lazyPut(()=>QuizController());
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
                      "Level "+level,
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
                      "-The quiz consists of 10 questions. \n-Time of quiz is 15 minutes.\n-Read the question carefully before answering.\n-The quiz was created by Dr. Sally and Dr. Salsabil.",
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
                    _submit(context);
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
