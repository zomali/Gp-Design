import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp/classes/classes.dart';
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
  late final String level;
  Map<int, int?> student_answers = {};
  QuizResults(this.level, this.student_answers);
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
              init: QuizController(),
              builder: (controller) =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "  Results Of Quiz Level " + level,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 10,
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
                            itemCount: controller.questionsList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 320,
                                        height: 320,
                                        margin: const EdgeInsets.only(
                                            top: 15.0, bottom: 15, left: 25),
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
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Question " + controller
                                                        .questionsList[index].id
                                                        .toString() + " / " +
                                                        controller.questionsList
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
                                                      .questionsList[index]
                                                      .answer,
                                                      student_answers[index +
                                                          1])
                                                ],
                                              ),

                                              SizedBox(height: 10,),
                                              Text(
                                                controller.questionsList[index]
                                                    .question,
                                                style: TextStyle(fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              condition(controller
                                                  .questionsList[index],
                                                  student_answers[index + 1])
                                             ,
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
                        height: 20,
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
  Widget condition(QuestionModel questionModel, int? selected_answer) {
    Widget widget;
    if(questionModel.options.length==2)
      {
         widget = Column(
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
                  child: Text(
                    (1).toString() + ". " + questionModel.options[0],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (2).toString() + ". " + questionModel.options[1],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                )),
            SizedBox(height: 10,),
          ],
        );
         //if not selected answer return right answer
         if(selected_answer==null)
         {
           if(questionModel.answer==0)
           {
             return  Column(
                 children: [
                   SizedBox(height: 40,),
                   Container(
                       width: 260,
                       height: 35,
                       margin: const EdgeInsets.symmetric(horizontal: 10.0),
                       decoration: BoxDecoration(
                         color: Colors.green,
                         borderRadius: BorderRadius.circular(25.0),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(
                             left: 30, top: 5.0, bottom: 5),
                         child:Text(
                           (1).toString()+". "+questionModel.options[0],
                           style: TextStyle(fontSize: 20,color: Colors.white),
                         ),
                       )),
                   SizedBox(height: 20,),
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
                         child:Text(
                           (2).toString()+". "+questionModel.options[1],
                           style: TextStyle(fontSize: 20,color: Colors.blue),
                         ),
                       )),
                   SizedBox(height: 10,),
                 ]);
           }
           if(questionModel.answer==1)
           {
             return Column(
                 children: [
                   SizedBox(height: 40,),
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
                         child:Text(
                           (1).toString()+". "+questionModel.options[0],
                           style: TextStyle(fontSize: 20,color: Colors.blue),
                         ),
                       )),
                   SizedBox(height: 20,),
                   Container(
                       width: 260,
                       height: 35,
                       margin: const EdgeInsets.symmetric(horizontal: 10.0),
                       decoration: BoxDecoration(
                         color: Colors.green,
                         borderRadius: BorderRadius.circular(25.0),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(
                             left: 30, top: 5.0, bottom: 5),
                         child:Text(
                           (2).toString()+". "+questionModel.options[1],
                           style: TextStyle(fontSize: 20,color: Colors.white),
                         ),
                       )),
                   SizedBox(height: 10,),
                 ]);
           }
         }
         //if selected answer
         else {
           switch (questionModel.answer == selected_answer) {
             case true:
               switch (questionModel.answer) {
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
    if(questionModel.options.length==4)
      {
        widget = Column(
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
                  child: Text(
                    (1).toString() + ". " + questionModel.options[0],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (2).toString() + ". " + questionModel.options[1],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (3).toString() + ". " + questionModel.options[2],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (4).toString() + ". " + questionModel.options[3],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                )),
            SizedBox(height: 10,),
          ],
        );
        //if not selected answer return right answer
        if(selected_answer==null)
        {
          if(questionModel.answer==0)
          {
            return  Column(
                children: [
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.white),
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
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                ]);
          }
          if(questionModel.answer==1)
          {
            return Column(
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
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.white),
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
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                ]);
          }
          if(questionModel.answer==2)
          {
            return Column(
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
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.white),
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
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                ]);
          }
          if(questionModel.answer==3)
          {
            return Column(
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
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      )),
                  SizedBox(height: 10,),
                ]);
          }
        }
        //if selected answer
        else {
          switch (questionModel.answer == selected_answer) {
            case true:
              switch (questionModel.answer) {
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
    else
      {
         widget = Column(
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
                  child: Text(
                    (1).toString() + ". " + questionModel.options[0],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (2).toString() + ". " + questionModel.options[1],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (3).toString() + ". " + questionModel.options[2],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                  child: Text(
                    (4).toString() + ". " + questionModel.options[3],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                )),
            SizedBox(height: 10,),
          ],
        );
      }
    return widget;
  }
  //get score of each question
  Widget get_score(int right_answer, int? selected_answer) {
    Widget widget;
    switch (right_answer == selected_answer) {
      case true:
        widget = Text(
          10.toString() + " / 10",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
        break;
      case false:
        widget = Text(
          0.toString() + " / 10",
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
  Widget get_correct_widget(int index, QuestionModel questionModel) {
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
                  child:Text(
                    (2).toString()+". "+questionModel.options[0],
                    style: TextStyle(fontSize: 20,color: Colors.blue),
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
                  child:Text(
                    (2).toString()+". "+questionModel.options[1],
                    style: TextStyle(fontSize: 20,color: Colors.blue),
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
                  child:Text(
                    (3).toString()+". "+questionModel.options[2],
                    style: TextStyle(fontSize: 20,color: Colors.blue),
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
                  child:Text(
                    (4).toString()+". "+questionModel.options[3],
                    style: TextStyle(fontSize: 20,color: Colors.blue),
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
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 5.0, bottom: 5),
                    child:Text(
                      (1).toString()+". "+questionModel.options[0],
                      style: TextStyle(fontSize: 20,color: Colors.white),
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
                    child:Text(
                      (2).toString()+". "+questionModel.options[1],
                      style: TextStyle(fontSize: 20,color: Colors.blue),
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
                    child:Text(
                      (3).toString()+". "+questionModel.options[2],
                      style: TextStyle(fontSize: 20,color: Colors.blue),
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
                      child:Text(
                        (4).toString()+". "+questionModel.options[3],
                        style: TextStyle(fontSize: 20,color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child:Text(
                        (1).toString()+". "+questionModel.options[0],
                        style: TextStyle(fontSize: 20,color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child:Text(
                        (2).toString()+". "+questionModel.options[1],
                        style: TextStyle(fontSize: 20,color: Colors.white),
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
                      child:Text(
                        (3).toString()+". "+questionModel.options[2],
                        style: TextStyle(fontSize: 20,color: Colors.blue),
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
                      child:Text(
                        (4).toString()+". "+questionModel.options[3],
                        style: TextStyle(fontSize: 20,color: Colors.blue),
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
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.white),
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
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (1).toString()+". "+questionModel.options[0],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (2).toString()+". "+questionModel.options[1],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
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
                        child:Text(
                          (3).toString()+". "+questionModel.options[2],
                          style: TextStyle(fontSize: 20,color: Colors.blue),
                        ),
                      )),
                  SizedBox(height: 10,),
                  Container(
                      width: 260,
                      height: 35,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 5.0, bottom: 5),
                        child:Text(
                          (4).toString()+". "+questionModel.options[3],
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      )),
                  SizedBox(height: 10,),
                ]);
          }
        }
      }
    return widget;
  }
  Widget get_wrong_widget(QuestionModel questionModel,selected_answer_index) {
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
                child:Text(
                  (2).toString()+". "+questionModel.options[0],
                  style: TextStyle(fontSize: 20,color: Colors.blue),
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
                child:Text(
                  (2).toString()+". "+questionModel.options[1],
                  style: TextStyle(fontSize: 20,color: Colors.blue),
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
                child:Text(
                  (3).toString()+". "+questionModel.options[2],
                  style: TextStyle(fontSize: 20,color: Colors.blue),
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
                child:Text(
                  (4).toString()+". "+questionModel.options[3],
                  style: TextStyle(fontSize: 20,color: Colors.blue),
                ),
              )),
          SizedBox(height: 10,),
        ]);
      //if correct answer is 0
      if (questionModel.answer == 0) {
        if (selected_answer_index == 1) {
          return Column(
              children: [
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
              ]);
        }
      }
      //if correct answer is 1
      else if (questionModel.answer == 1) {
        if (selected_answer_index == 0) {
          return Column(
              children: [
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
              ]);
        }
      }
      else if (questionModel.answer == 2) {
        if (selected_answer_index == 0) {
          return Column(
              children: [
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
              ]);
        }
      }
      else if (questionModel.answer == 3) {
        if (selected_answer_index == 0) {
          return Column(
              children: [
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (1).toString() + ". " + questionModel.options[0],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
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
                      child: Text(
                        (2).toString() + ". " + questionModel.options[1],
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (3).toString() + ". " + questionModel.options[2],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
                Container(
                    width: 260,
                    height: 35,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, top: 5.0, bottom: 5),
                      child: Text(
                        (4).toString() + ". " + questionModel.options[3],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10,),
              ]);
        }
      }
    return widget;
  }
  //if true or false question
  Widget get_correct_widget_len_2(int index, QuestionModel questionModel) {
  Widget widget= Column(
      children: [
        SizedBox(height: 40,),
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
              child:Text(
                (2).toString()+". "+questionModel.options[0],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            )),
        SizedBox(height: 20,),
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
              child:Text(
                (2).toString()+". "+questionModel.options[1],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            )),
        SizedBox(height: 10,),
      ]);
  if(index ==0)
  {
    return Column(
        children: [
          SizedBox(height: 40,),
          Container(
              width: 260,
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 5.0, bottom: 5),
                child:Text(
                  (1).toString()+". "+questionModel.options[0],
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              )),
          SizedBox(height: 20,),
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
                child:Text(
                  (2).toString()+". "+questionModel.options[1],
                  style: TextStyle(fontSize: 20,color: Colors.blue),
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
            SizedBox(height: 40,),
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
                  child:Text(
                    (1).toString()+". "+questionModel.options[0],
                    style: TextStyle(fontSize: 20,color: Colors.blue),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child:Text(
                    (2).toString()+". "+questionModel.options[1],
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  return widget;
}
  Widget get_wrong_widget_len_2(QuestionModel questionModel,selected_answer_index) {
  Widget widget= Column(
      children: [
        SizedBox(height: 40,),
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
              child:Text(
                (2).toString()+". "+questionModel.options[0],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            )),
        SizedBox(height: 20,),
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
              child:Text(
                (2).toString()+". "+questionModel.options[1],
                style: TextStyle(fontSize: 20,color: Colors.blue),
              ),
            )),
        SizedBox(height: 10,),
      ]);
  //if correct answer is 0
  if (questionModel.answer == 0) {
    if (selected_answer_index == 1) {
      return Column(
          children: [
            SizedBox(height: 40,),
            Container(
                width: 260,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: Text(
                    (1).toString() + ". " + questionModel.options[0],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: Text(
                    (2).toString() + ". " + questionModel.options[1],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            SizedBox(height: 10,),
          ]);
    }
  }
  //if correct answer is 1
  else if (questionModel.answer == 1) {
    if (selected_answer_index == 0) {
      return Column(
          children: [
            SizedBox(height: 40,),
            Container(
                width: 260,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: Text(
                    (1).toString() + ". " + questionModel.options[0],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: 260,
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 5.0, bottom: 5),
                  child: Text(
                    (2).toString() + ". " + questionModel.options[1],
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
          ]);
    }
  }
  return widget;
}