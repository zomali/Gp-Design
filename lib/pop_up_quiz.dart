import 'package:flutter/material.dart';
class pop_up_quiz extends StatefulWidget {
  const pop_up_quiz({Key? key}) : super(key: key);
  @override
  State<pop_up_quiz> createState() => _pop_up_quiz();
}
class _pop_up_quiz extends State<pop_up_quiz> {
  String? selectedChoice = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue,
        child: Container(
            height: 500,
            width: 500,
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 10.0,
              right:10.0,
            ),
            child:Column(
              children: <Widget>[
                Text(
                  "Quiz",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "How many",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),
                ),
                RadioListTile<String>(
                  title: const Text('Lafayette',style: TextStyle(color: Colors.white,fontSize: 20),),
                  value:"first",
                  groupValue: selectedChoice,
                  onChanged: (value) {
                    setState(() {
                      value = selectedChoice;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Lafayette',style: TextStyle(color: Colors.white,fontSize: 20),),
                  value: "second",
                  groupValue: selectedChoice,
                  onChanged: ( value) {
                    setState(() {
                      value = selectedChoice;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Lafayette',style: TextStyle(color: Colors.white,fontSize: 20),),
                  value: "third",
                  groupValue: selectedChoice,
                  onChanged: ( value) {
                    setState(() {
                      value = selectedChoice;
                    });
                  },
                ),RadioListTile<String>(
                  title: const Text('Lafayette',style: TextStyle(color: Colors.white,fontSize: 20),),
                  value: "fourth",
                  groupValue: selectedChoice,
                  onChanged: ( value) {
                    setState(() {
                      value = selectedChoice;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
        ));
  }
}