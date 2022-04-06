import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Start_Quiz.dart';
import 'package:gp/classes/student.dart';
import 'L_types.dart';
class topic_data{
  var topic_index = [
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
  ];
  var level_name = [
    "geeksforgeeks",
    "Revision, Variables & Constant",
    "Revision, Variables & Constant",
    "Revision, Variables & Constant",
  ];
}
class topic_view extends StatefulWidget  {

  const topic_view({Key? key}) : super(key: key);
  @override
  _topic_view createState() => _topic_view();
}

class _topic_view extends State<topic_view> {

  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    var level_name="Introduction";
    var topic_name = [
      "Revision, Variables & Constants",
      "Control Structures",
      "Jump Statements",
    ];

    var index_topic = [
      "First Topic",
      "Second Topic",
      "Third Topic",
    ];
    return Scaffold(
     backgroundColor: Colors.white,
     body:Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)
            ),
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
                      )
                    ),
                  )),
              Positioned(
                top: 100,
                  left: 20,
                  child: Text(level_name,style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
            ],
          ),
        ),
        SizedBox(height: height*0.02,),
        Expanded(
          child:MediaQuery.removePadding(context:context,
            removeTop: true,
            child:ListView.builder(
              itemCount: topic_name.length,
              itemBuilder: (context, index)
            {
              return GestureDetector(
                  onTap: (){
                    //action on tap
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Start_Quiz()));
                  },
                  child:Card(
                    child:Row(
                      children:<Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 10,top: 25),
                      height: 150,
                      width: width*0.9,
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80.0)
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: new Offset(-10.0, 10.0),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 32,top: 20.0,bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(index_topic[index],style: TextStyle(fontSize: 16,color: Colors.white),),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(topic_name[index],style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                ]
                    ),
                  )
              );
            },
            ),
     ),
        )]
   ));
  }

}