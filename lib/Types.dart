import 'package:flutter/material.dart';
import 'L_types.dart';
import 'Levels.dart';
//import 'package:flutter/Levels.dart';

class Types extends StatelessWidget {
  final int index;
  final List<bool>know;
  Types(this.index,this.know);
  change(){
    know[index+1]=true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("types"),),
      body:Center(

          child:Column(children: [
            Text("level $index"),
            ElevatedButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> types()));
            }, child:const Text("Select your type"))
          ],) ) ,

    );
  }
}
