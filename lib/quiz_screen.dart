import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gp/countdown_timer.dart';
import 'question_model.dart';
import 'dart:ui';
import 'score_screen.dart';
import 'start_quiz_view.dart';

class AppColor {
  static final pripmaryColor = Color(0xFF252c4a);
  static final secondaryColor = Colors.blue;
}
class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}
class _QuizzScreenState extends State<QuizzScreen> with SingleTickerProviderStateMixin  {
  static late DateTime cur_time;
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  bool click =false;
   late AnimationController _animationController;
  final limitTime=10;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _animationController=AnimationController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*countdown(animation:StepTween(
                        begin: 100,
                        end: 0).animate(_animationController)),*/
                  SizedBox(width: 150),
                  RawMaterialButton(
                    onPressed: () {
                      if (_controller!.page?.toInt() == questions.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(score)));
                      } else {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);
                        setState(() {
                          btnPressed = false;
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: Colors.blue,
                    padding: EdgeInsets.all(5.0),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color:Colors.white),
                    ),
                  ),

            ]
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}/10",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Divider(
                    color:AppColor.secondaryColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: Text(
                      "${questions[index].question}",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        fillColor: btnPressed
                            ? questions[index].answers!.values.toList()[i]
                            ? Colors.green
                            : Colors.red
                            : AppColor.secondaryColor,
                        onPressed:
                        !answered
                            ? () {
                          if (questions[index]
                              .answers!
                              .values
                              .toList()[i]) {
                            score++;
                            print("yes");
                          } else {
                            print("no");
                          }
                          setState(() {
                            answered = true;
                            btnPressed=true;
                          });
                        }
                            : null,
                        child: Text(questions[index].answers!.keys.toList()[i],
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}