import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/Quiz/go_to_quiz.dart';
import 'Quiz/Start_Quiz.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';
import 'L_types.dart';
import 'l2.dart';

class topic_view extends StatefulWidget {
  final student std;
  final Level_ level;

  topic_view(this.std, this.level);
  @override
  _topic_view createState() => _topic_view(std, level);
}

class _topic_view extends State<topic_view> {
  student std;
  Level_ level;
  _topic_view(this.std, this.level);
  List<int>weakness_topics=[1,2,3];
  List<TopicsPlusQuiz> topicsPlusQuiz = <TopicsPlusQuiz>[];
  @override
  void initState() {
    super.initState();
    topicsPlusQuiz = initializeTopicsList(topicsPlusQuiz, level);
  }

  Widget putIcon(index) {
    if ((std.current_topic - 1) < index) {
      return const Icon(Icons.lock);
    } else {
      return const Icon(Icons.lock_open);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                      color: Colors.blue,
                    ),
                    child: Stack(children: [
                      Positioned(
                          top: 30,
                          left: 0,
                          child: Container(
                            height: 50,
                            width: 310,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                )),
                          )),
                      Positioned(
                        top: 30,
                        left: 0,
                        child: Row(children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => levels_view(std)));
                            },
                          ),
                          Text(
                            level.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ]),
                      )
                    ]),
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: topicsPlusQuiz.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (index == topicsPlusQuiz.length - 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          go_to_quiz(level.id,"level",weakness_topics)));
                                } else {
                                  //action on tap
                                  //Fluttertoast.showToast(msg:level.id.toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          types(std, level, level.topics[index])));
                                }
                                //code of locked topics
                                /*if (TopicList[index].id <= std.courses['CSW150']['current_level']) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          topic_view(std, levelsList[index])));
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Unlock this level first to view it",
                                  );
                                }*/
                              },
                              child: Card(
                                child: Row(children: <Widget>[
                                  putIcon(index),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                                    height: 120,
                                    width: width * 0.9,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(80.0)),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            offset: new Offset(-10.0, 10.0),
                                            blurRadius: 20.0,
                                            spreadRadius: 4.0,
                                          )
                                        ],
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 22, top: 20.0, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            topicsPlusQuiz[index].topicID,
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            topicsPlusQuiz[index].topicName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ));
                        },
                      ),
                    ),
                  ),
                ])         
        );
  }
}

class TopicsPlusQuiz {
  late String topicID;
  late String topicName;
}

List<TopicsPlusQuiz> initializeTopicsList(
    List<TopicsPlusQuiz> topicsPlusQuiz, Level_ level) {
  //add quiz to topics list
  topicsPlusQuiz = <TopicsPlusQuiz>[];
  for (var topic in level.topics) {
    TopicsPlusQuiz TPQ = new TopicsPlusQuiz();
    TPQ.topicID = "Topic " + topic.id.toString();
    TPQ.topicName = topic.name;
    topicsPlusQuiz.add(TPQ);
  }
  TopicsPlusQuiz TPQ = new TopicsPlusQuiz();
  TPQ.topicID = "  ";
  TPQ.topicName = "Quiz " + level.id.toString();
  topicsPlusQuiz.add(TPQ);

  return topicsPlusQuiz;
}
