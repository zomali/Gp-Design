import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/Start_Quiz.dart';
import 'package:gp/Topic_view.dart';
import 'package:gp/classes/student.dart';
import 'L_types.dart';

class levels_view extends StatefulWidget {
  final student std;
  levels_view(this.std);
  @override
  _levels_view createState() => _levels_view(std);
}

class _levels_view extends State<levels_view> {
  student std;
  _levels_view(this.std);
  set value(String? value) {}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    String? value;
    var course_name = "Structered Programming";
    var Level_name = [
      "Introduction",
      "Arrays, Search & Nested Loops",
      "Functions",
      "Structures",
      "Pointers & Dynamic Arrays",
    ];
    var Level_index = [
      "First Level",
      "Second Level",
      "Third Level",
      "Fourth Level",
      "Fifth Level",
    ];
    var Level_content = [
      "Three Topic",
      "Two Topic",
      "Four Topic",
      "Three Topic",
      "Four Topic",
    ];
    return Scaffold(
        backgroundColor: Colors.white,
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
                      height: 80,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )),
                    )),
                Positioned(
                    top: 110,
                    left: 20,
                    child: Text(
                      course_name,
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
                itemCount: Level_name.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        //action on tap
                        if (index < std.courses['CSW150']['current_level']) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  topic_view(std, index + 1)));
                        } else {
                          Fluttertoast.showToast(
                            msg: "can't enter to this level",
                          );
                        }
                      },
                      onLongPress: () {},
                      child: Card(
                        child: Row(children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 25),
                            height: 180,
                            width: width * 0.9,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(80.0)),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: new Offset(-10.0, 10.0),
                                    blurRadius: 20.0,
                                    spreadRadius: 4.0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                  left: 32, top: 30.0, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Level_index[index],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    Level_name[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    Level_content[index],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  /*DropdownButton<String>(
                                           value: value,
                                           iconSize: 36,
                                           isExpanded: true,
                                           icon: Icon(Icons.arrow_drop_down,color:Colors.white),
                                           items: [],
                                           onChanged: (value)=>setState(()=> this.value=value),

                                         )*/
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
