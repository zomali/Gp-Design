import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/Start_Quiz.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'L_types.dart';

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
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => levels_view(std)));            
          },
          ),),
        body: Column(children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              color: Colors.blue,
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 80,
                    left: 0,
                    child: Container(
                      height: 90,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )),
                    )),
                Positioned(
                    top: 100,
                    left: 20,
                    child: Text(
                      level.name,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: level.topics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        //action on tap
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                types(std, level, level.topics[index])));
                      },
                      child: Card(
                        child: Row(children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 25),
                            height: 150,
                            width: width * 0.9,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
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
                                  left: 32, top: 20.0, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Topic " +
                                    level.topics[index].id.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    level.topics[index].name,
                                    style: TextStyle(
                                        fontSize: 22,
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
          )
        ]));
  }
}
