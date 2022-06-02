import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/student.dart';
import 'question__model.dart';
import 'bindings_app.dart';
import 'custom_button.dart';
import 'answer_option.dart';
import 'progress_timer.dart';
import 'question_card.dart';
import 'quiz__screen.dart';
import 'quiz_controller.dart';
import 'result_screen.dart';
import 'backButton.dart';
//import 'quiz_selected_controller.dart';
class QuizResults extends StatelessWidget {
  final int id;
  final student std;
  Map<int, int?> student_answers = {};
  List<Question_>questions;
  String stat;
  QuizResults(this.id, this.std, this.student_answers,this.questions,this.stat);
  List<int>weakness_topics=[];
  late int score;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(0,std,stat,weakness_topics,questions),
              builder: (controller) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "  Results Of Quiz "+stat +" "+ id.toString(),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          )
                      ),
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: controller.quiz_question.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 320,
                                        margin: const EdgeInsets.only(
                                            top: 5.0, bottom: 5, left: 25),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                              25.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Question " + (index+1).toString() + " / " +
                                                        controller.quiz_question
                                                            .length.toString(),
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline5
                                                        ?.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(width: 50,),
                                                  get_score(controller
                                                      .quiz_question[index]
                                                      .answer_id,
                                                      student_answers[controller.quiz_question[index].id],controller.quiz_question[index].points)
                                                ],
                                              ),

                                              SizedBox(height: 20,),
                                              Text(
                                                controller.quiz_question[index]
                                                    .question,
                                                style: TextStyle(fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),

                                                  condition(controller.quiz_question[index],student_answers[controller.quiz_question[index].id]),

                                            ],
                                          ),
                                        ),)
                                    ]),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget condition(Question_ questionModel, int? selected_answer) {
  Widget widget;
  if(questionModel.choices.length==2)
  {
    widget = Column(
      children: [
          Container(
              width: 280,
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5.0, bottom: 5, right:10),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:"A. " + questionModel.choices[0],
                    style: TextStyle(fontSize: 15, color: Colors.blue),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
          Container(
                  width: 260,
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 5.0, bottom: 5,right:10),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:"B. " + questionModel.choices[1],
                        style: TextStyle(fontSize: 15, color: Colors.blue),),
                    ]),
                    ),
                    ),
                  ),
          SizedBox(height: 10,),
      ],
    );
    //if not selected answer return right answer
    if(selected_answer==null)
    {
      if(questionModel.answer_id==0)
      {
        return  Column(
            children: [
              SizedBox(height: 20,),
              Container(
                      width: 260,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5.0, bottom: 5,right:10),
                        child: RichText(text: TextSpan(children:<TextSpan>[
                          TextSpan(text:"A. "+questionModel.choices[0],
                            style: TextStyle(fontSize: 15,color: Colors.white),),
                        ]),
                        ),
                        ),
                      ),
              SizedBox(height: 20,),
              Container(
                      width: 260,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5.0, bottom: 5,right:10),
                        child: RichText(text: TextSpan(children:<TextSpan>[
                          TextSpan(text:"B. "+questionModel.choices[1],
                            style: TextStyle(fontSize: 15,color: Colors.blue),),
                        ]),
                        ),
                      )),
              SizedBox(height: 10,),
            ]);
      }
      if(questionModel.answer_id==1)
      {
        return Column(
            children: [
              SizedBox(height: 20,),
              Container(
                      width: 260,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 5.0, bottom: 5, right:10),
                        child: RichText(text: TextSpan(children:<TextSpan>[
                          TextSpan(text: "A. "+questionModel.choices[0],
                            style: TextStyle(fontSize: 15,color: Colors.blue),),
                        ]),
                        ),),),
              SizedBox(height: 20,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5.0, bottom: 5,right:10),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "B. "+questionModel.choices[1],
                          style: TextStyle(fontSize: 15,color: Colors.white),),
                      ]),
                      ),
                    ),),
              SizedBox(height: 10,),
            ]);
      }
    }
    //if selected answer
    else {
      switch (questionModel.answer_id == selected_answer) {
        case true:
          switch (questionModel.answer_id) {
            case 0:
              return get_correct_widget_len_2(0, questionModel);
            case 1:
              return get_correct_widget_len_2(1, questionModel);
          }
          break;
        case false:
          return get_wrong_widget_len_2(questionModel, selected_answer);
      }
    }
  }
  if(questionModel.choices.length==4)
  {
    widget = Column(
      children: [
        Wrap(children:[
          Container(
              width: 260,
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5.0, bottom: 5, right:10),
                child: Text(
                  "A. " + questionModel.choices[0],
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )),
        ],),
        SizedBox(height: 10,),
        Wrap(children: [
          Container(
              width: 260,
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5.0, bottom: 5,right:10),
                child: Text(
                  "B. " + questionModel.choices[1],
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )),
        ],),
        SizedBox(height: 10,),
        Wrap(children: [
          Container(
              width: 260,
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10,right:10, top: 5.0, bottom: 5),
                child: Text(
                  "C. " + questionModel.choices[2],
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )),
        ],),
        SizedBox(height: 10,),
        Wrap(children: [
          Container(
              width: 260,
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right:10,top: 5.0, bottom: 5),
                child: Text(
                  "D. " + questionModel.choices[3],
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
              )),
        ],),
        SizedBox(height: 10,),
      ],
    );
    //if not selected answer return right answer
    if(selected_answer==null)
    {
      if(questionModel.answer_id==0)
      {
        return  Column(
            children: [
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "A. "+questionModel.choices[0],
                          style: TextStyle(fontSize: 20,color: Colors.white),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "B. "+questionModel.choices[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "C. "+questionModel.choices[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "D. "+questionModel.choices[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
            ]);
      }
      if(questionModel.answer_id==1)
      {
        return Column(
            children: [
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "A. "+questionModel.choices[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "B. "+questionModel.choices[1],
                          style: TextStyle(fontSize: 20,color: Colors.white),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "C. "+questionModel.choices[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text:  "D. "+questionModel.choices[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
            ]);
      }
      if(questionModel.answer_id==2)
      {
        return Column(
            children: [
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text:  "A. "+questionModel.choices[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text:  "B. "+questionModel.choices[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text:  "C. "+questionModel.choices[2],
                          style: TextStyle(fontSize: 20,color: Colors.white),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text:  "D. "+questionModel.choices[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
            ]);
      }
      if(questionModel.answer_id==3)
      {
        return Column(
            children: [
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "A. "+questionModel.choices[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "B. "+questionModel.choices[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "C. "+questionModel.choices[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
              Container(
                    width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: RichText(text: TextSpan(children:<TextSpan>[
                        TextSpan(text: "D. "+questionModel.choices[3],
                          style: TextStyle(fontSize: 20,color: Colors.white),),
                      ]),
                      ),
                    )),
              SizedBox(height: 10,),
            ]);
      }
    }
    //if selected answer
    else {
      switch (questionModel.answer_id == selected_answer) {
        case true:
          switch (questionModel.answer_id) {
            case 0:
              return get_correct_widget(0, questionModel);
            case 1:
              return get_correct_widget(1, questionModel);
            case 2:
              return get_correct_widget(2, questionModel);
            case 3:
              return get_correct_widget(3, questionModel);
          }
          break;
        case false:
          return get_wrong_widget(questionModel, selected_answer);
      }
    }
  }
  //not done
  else
  {
    widget = Column(
      children: [
        Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text: "A. " + questionModel.choices[0],
                    style: TextStyle(fontSize: 20, color: Colors.blue),),
                ]),
                ),
              )),
        SizedBox(height: 10,),
        Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text: "B. " + questionModel.choices[1],
                    style: TextStyle(fontSize: 20, color: Colors.blue),),
                ]),
                ),
              )),
        SizedBox(height: 10,),
        Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text: "C. " + questionModel.choices[2],
                    style: TextStyle(fontSize: 20, color: Colors.blue),),
                ]),
                ),
              )),
        SizedBox(height: 10,),
        Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text: "D. " + questionModel.choices[3],
                    style: TextStyle(fontSize: 20, color: Colors.blue),),
                ]),
                ),
              )),
        SizedBox(height: 10,),
      ],
    );
  }
  return widget;
}
//get score of each question
Widget get_score(int right_answer, int? selected_answer,int points) {
  Widget widget;
  switch (right_answer == selected_answer) {
    case true:
      widget = Text(
        points.toString() + " / " + points.toString(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      break;
    case false:
      widget = Text(
        0.toString() + " / "+points.toString(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      break;
    default:
      widget = Container();
  }
  return widget;
}
//if mcq question
Widget get_correct_widget(int index, Question_ questionModel) {
  Widget widget= Column(
      children: [
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:"A. "+questionModel.choices[0],
                    style: TextStyle(fontSize: 20,color: Colors.blue),),
                ]),
                ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:"B. "+questionModel.choices[1],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:"C. "+questionModel.choices[2],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:"D. "+questionModel.choices[3],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
      ]);
  if(index ==0)
  {
    return Column(
        children: [
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10,right:10, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text: "A. "+questionModel.choices[0],
                    style: TextStyle(fontSize: 15,color: Colors.white),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10,right:10, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:  "B. "+questionModel.choices[1],
                    style: TextStyle(fontSize: 15,color: Colors.blue),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:  "C. "+questionModel.choices[2],
                    style: TextStyle(fontSize: 20,color: Colors.blue),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:  "D. "+questionModel.choices[3],
                    style: TextStyle(fontSize: 20,color: Colors.blue),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
        ]);
  }
  if(index ==1)
  {
    {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "A. "+questionModel.choices[0],
                      style: TextStyle(fontSize: 20,color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "B. "+questionModel.choices[1],
                      style: TextStyle(fontSize: 20,color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "C. "+questionModel.choices[2],
                      style: TextStyle(fontSize: 20,color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "D. "+questionModel.choices[3],
                      style: TextStyle(fontSize: 20,color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  if(index==2)
  {
    {
      {
        return Column(
            children: [
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:    "A. "+questionModel.choices[0],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:    "B. "+questionModel.choices[1],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:    "C. "+questionModel.choices[2],
                        style: TextStyle(fontSize: 20,color: Colors.white),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:    "D. "+questionModel.choices[3],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
            ]);
      }
    }
  }
  if(index ==3)
  {
    {
      {
        return Column(
            children: [
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:     "A. "+questionModel.choices[0],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:      "B. "+questionModel.choices[1],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:      "C. "+questionModel.choices[2],
                        style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child: RichText(text: TextSpan(children:<TextSpan>[
                      TextSpan(text:     "D. "+questionModel.choices[3],
                        style: TextStyle(fontSize: 20,color: Colors.white),),
                    ]),
                    ),
                  )),
              SizedBox(height: 10,),
            ]);
      }
    }
  }
  return widget;
}
Widget get_wrong_widget(Question_ questionModel,selected_answer_index) {
  Widget widget= Column(
      children: [
        Container(
            width: 260,
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:    "A. "+questionModel.choices[0],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:     "B. "+questionModel.choices[1],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:     "C. "+questionModel.choices[2],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
        Container(
            width: 260,
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:     "D. "+questionModel.choices[3],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
      ]);
  //if correct answer is 0
  if (questionModel.answer_id == 0) {
    if (selected_answer_index == 1) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 2) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 3) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:       "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:         "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:         "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  //if correct answer is 1
  else if (questionModel.answer_id == 1) {
    if (selected_answer_index == 0) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:         "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:           "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:            "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:            "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 2) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:            "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 3) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:              "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:               "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:                "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:  "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  else if (questionModel.answer_id == 2) {
    if (selected_answer_index == 0) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 1) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:   "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:    "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 3) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:     "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:      "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:       "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:       "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  else if (questionModel.answer_id == 3) {
    if (selected_answer_index == 0) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:         "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:         "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:          "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:          "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 1) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:          "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:           "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
    else if (selected_answer_index == 2) {
      return Column(
          children: [
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "C. " + questionModel.choices[2],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "D. " + questionModel.choices[3],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  return widget;
}
//if true or false question
Widget get_correct_widget_len_2(int index, Question_ questionModel) {
  Widget widget= Column(
      children: [
        SizedBox(height: 20,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:               "A. "+questionModel.choices[0],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),

            )),
        SizedBox(height: 20,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child: RichText(text: TextSpan(children:<TextSpan>[
                TextSpan(text:               "B. "+questionModel.choices[1],
                  style: TextStyle(fontSize: 20,color: Colors.blue),),
              ]),
              ),
            )),
        SizedBox(height: 10,),
      ]);
  if(index ==0)
  {
    return Column(
        children: [
          SizedBox(height: 20,),
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:               "A. "+questionModel.choices[0],
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                ]),
                ),
              )),
          SizedBox(height: 20,),
          Container(
              width: 260,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child: RichText(text: TextSpan(children:<TextSpan>[
                  TextSpan(text:                "B. "+questionModel.choices[1],
                    style: TextStyle(fontSize: 20,color: Colors.blue),),
                ]),
                ),
              )),
          SizedBox(height: 10,),
        ]);
  }
  if(index ==1)
  {
    {
      return Column(
          children: [
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:             "A. "+questionModel.choices[0],
                      style: TextStyle(fontSize: 20,color: Colors.blue),),
                  ]),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:              "B. "+questionModel.choices[1],
                      style: TextStyle(fontSize: 20,color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  return widget;
}
Widget get_wrong_widget_len_2(Question_ questionModel,selected_answer_index) {
  Widget widget= Column(
      children: [
        SizedBox(height: 20,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child:Wrap(
                children: [
              Text(
                "A. "+questionModel.choices[0],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),]),
            )),
        SizedBox(height: 20,),
        Container(
            width: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 5.0, bottom: 5),
              child:Wrap(
                children: [
             Text(
                "B. "+questionModel.choices[1],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),]),
            )),
        SizedBox(height: 10,),
      ]);
  //if correct answer is 0
  if (questionModel.answer_id == 0) {
    if (selected_answer_index == 1) {
      return Column(
          children: [
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:               "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:                "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  //if correct answer is 1
  else if (questionModel.answer_id == 1) {
    if (selected_answer_index == 0) {
      return Column(
          children: [
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:               "A. " + questionModel.choices[0],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: RichText(text: TextSpan(children:<TextSpan>[
                    TextSpan(text:               "B. " + questionModel.choices[1],
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                  ]),
                  ),
                )),
          ]);
    }
  }
  return widget;
}
String get_title(String stat,int id)
{
  final List<Levels> levels=[
    Levels(level_id: 1, topics_id: [1,2,3]),
    Levels(level_id: 2, topics_id: [4,5,6]),
    Levels(level_id: 3, topics_id: [7,8,9,10]),
    Levels(level_id: 4, topics_id: [11,12,13]),
    Levels(level_id: 5, topics_id: [14,15,16,17]),
  ];
  String title="";
  if(stat=="level")
    {
      title="Level"+id.toString();
    }
  else if(stat=="topic")
    {
      int level=0;
      if(id==1 ||id==2||id==3)
        {
          level=1;
        }
      if(id==4 ||id==5||id==6)
      {
        level=2;
      }
      if(id==7 ||id==8||id==9||id==10)
      {
        level=3;
      }
      if(id==11 ||id==12 || id==13)
      {
        level=4;
      }
      if(id==15 ||id==16||id==17||id==18)
      {
        level=5;
      }
      title="Level "+level.toString()+" Topic "+id.toString();
    }
  return title;
}