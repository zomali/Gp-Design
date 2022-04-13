import 'package:flutter/material.dart';
import 'package:gp/Sidebar/BlockNavigation.dart';
import 'package:gp/login_screen.dart';
class INFO extends StatelessWidget with NavigationStates {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text('Info '),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login_screen()));
            // _selectedIndex-=2;
          },
        ),
      ),
      body: Padding(

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text('Course by DR.Sallly Saad' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),
            SizedBox(height: 10.0,),
            Text('TA: DR.ss' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),
            SizedBox(height: 10.0,),
            Text('TA: DR.vv' , style: TextStyle(fontSize: 20.0,color: Colors.black,),),

          ],


        ),
      ),
    );
  }
}