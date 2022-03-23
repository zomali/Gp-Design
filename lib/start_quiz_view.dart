import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'question_model.dart';

class Start_quiz extends StatefulWidget {
  const Start_quiz({Key? key}) : super(key: key);

  @override
  _Start_quiz createState() => _Start_quiz();
}

class _Start_quiz extends State<Start_quiz> {
  static late DateTime open_time;
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
          height: 300,),
      ),
            SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "-The quiz consists of 10 questions. \n-Time of quiz is 15 minutes.\n-Read the question carefully before answering.\n-The quiz was created by Dr. Sally and Dr. Salsabil.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RawMaterialButton(
                  onPressed: () {
                    //Navigating the the Quizz Screen
                    open_time=new DateTime.now();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzScreen(),
                        ));
                  },
                  shape: const StadiumBorder(),
                  fillColor: AppColor.secondaryColor,
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
          ],
        ),
      ),
    );
  }
}