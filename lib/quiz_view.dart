import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';
//import 'quiz_selected_controller.dart';
class QuizResults extends StatelessWidget {
  final int id;
  final student std;
  final List<Q_Question_> quizQuestions;
  final String title;
  final String stat;
  QuizResults(this.id, this.std,this.stat, this.quizQuestions, this.title);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          QuestionCubit.get(context).get_list_of_questions(getIDs(quizQuestions));
          return BlocBuilder<QuestionCubit, QuestionState>(
            builder: (context, state) {
              if(state is QuestionLoading)
              {
                return Center(child: CircularProgressIndicator());
              }
              else {
                var questionCubit = QuestionCubit.get(context);
                //var Questions = questionCubit.quizQuestions;
                Map<int, int?> student_answers = get_answers(quizQuestions);
                List<Question_>questions = get_questions(questionCubit.quizQuestions);
                return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white),
                  ),
                  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 40.0, left: 40.0),
                                          child: Text(
                                          title,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(color: Colors.blue),
                                        ),
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
                                    itemCount: questions.length,
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
                                                                questions
                                                                 .length.toString(),
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .headline5
                                                                ?.copyWith(
                                                                color: Colors.white),
                                                          ),
                                                          SizedBox(width: 50,),
                                                          get_score(questions[index]
                                                              .answer_id,
                                                              student_answers[questions[index].id],questions[index].points)
                                                        ],
                                                      ),
          
                                                      SizedBox(height: 20,),
                                                      Text(
                                                       questions[index]
                                                            .question,
                                                        style: TextStyle(fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
          
                                                          condition(questions[index],student_answers[questions[index].id]),
          
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
                ],
              );
              }
            }
          );
        }
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

List<int> getIDs(List<Q_Question_> quizQuestions)
{
  List<int> IDs = [];
  for(var question in quizQuestions)
  IDs.add(question.id);

  return IDs;
}
Map<int,int>get_answers(List<Q_Question_> quizQuestions)
{
  Map<int,int> answers = new Map();
     for(var question in quizQuestions)
     {
       answers[question.id]=question.student_answer_id!;

     }
     return answers;
}
List<Question_>get_questions(List<Q_Question_> quizQuestions)
{
  List<Question_> questions = [];
     for(var question in quizQuestions)
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