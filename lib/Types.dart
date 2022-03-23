import 'package:flutter/material.dart';
import 'package:gp/topic_images.dart';
import 'L_types.dart';
import 'Levels.dart';
import 'URL_view.dart';
//import 'package:flutter/Levels.dart';

class Types extends StatelessWidget {
  final int index;
  final  List<bool>know;
  Types(this.index,this.know);
  change(){
    know[index+1]=true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Types"),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Levels(index)));
           // _selectedIndex-=2;

          },),
      ),
      body:Center(

          child:Column(children: [
            Text("level $index"),
            ElevatedButton(onPressed: (){

              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> types()));


            }, child:const Text("Select your type",)),
            ElevatedButton(onPressed: (){

              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> image_view()));


            }, child:const Text("Go to links",))
          ],) ) ,

    );
  }
}
