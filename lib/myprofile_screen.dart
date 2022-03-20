import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:gp/Courses_evaluations_Screen.dart';
import 'package:gp/Home.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Learning_analytics_screen.dart';
import 'package:gp/Levels.dart';
import 'package:gp/edit_profile%20screen.dart';
//import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
//import 'lib.dart';
import 'package:percent_indicator/percent_indicator.dart';
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int _selectedIndex = 3;
 // int _selectedIndex = 2;
  static  List<Widget> _pages = <Widget>[
    Home(0),
    Learning_analytics_screen(),


    Courses_evaluations_Screen(),
    MyProfileScreen(),

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;


      //   print("index = ${widget.ind} ");
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>moveToPage(index)));



    },
    );
  }
  Widget moveToPage(int index){

    return _pages.elementAt(_selectedIndex);
  }

  // double _progressValue=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
            "My Profile"
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Home(0)));
            _selectedIndex-=3;

          },),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize:16 ,


        unselectedItemColor: Colors.grey ,
        // unselectedFontSize: 11,
        unselectedFontSize: 16,

        //    currentIndex: 0,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.blue,
            //   backgroundColor: Colors.blue,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            //  icon: Icon(Icons.up),
            label: 'Analytics',

            // backgroundColor: Colors.blue,
            //     backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_outlined),
            label: 'Evaluation',
            //  backgroundColor: Colors.blue
            //    backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Dashboard',
            //   backgroundColor: Colors.blue
            //     backgroundColor: Colors.blue,
          )
        ],
        // onTap: (index){
        //   print("index = ${widget.ind} ");
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context)=>moveToPage(index)));
        //
        //
        //
        // },
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(

            children: [
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        backgroundImage:AssetImage('proj_images/me.jpg'),
                        //  backgroundImage: NetworkImage('https://png.pngtree.com/element_our/png_detail/20181208/male-student-icon-png_265268.jpg'),
                        radius: 55,

                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,

                      ),
                      IconButton(


                        icon: const Icon(Icons.edit_sharp,color: Colors.blue,size:40,),
                    //    alignment: Alignment.bottomRight,

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>Edit_Proile_Screen()
                              )
                          );
                        },),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                 Column(
                   children: [
                     Text(
                         "Hazem Ali",
                       style: TextStyle(
                         fontSize: 32,
                      //   color : Colors.blue[600],
                         fontWeight: FontWeight.bold,
                         fontStyle: FontStyle.italic,
                       ),
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     Text(
                       "Student,Ain-Shams University",
                       style: TextStyle(
                         fontSize: 12,
                        // color : Colors.blue[300],
                        // fontWeight: FontWeight.bold,
                         // fontStyle: FontStyle.italic,
                       ),
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     Text(
                       "2018170135",
                       style: TextStyle(
                         fontSize: 12,
                         //color : Colors.blue[300],
                         //fontWeight: FontWeight.bold,
                         // fontStyle: FontStyle.italic,
                       ),
                     ),
                   ],
                 ),


                ],
              ),//Edit && Info






              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.end,

                  decoration: InputDecoration(

                    prefixIcon:Text(

                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),



                    ),


                    hintStyle:TextStyle(
                      fontSize: 20,
                      //color : Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      color : Colors.black,
                      // fontStyle: FontStyle.italic,
                    ),
                    //alignLabelWithHint: ,
                    hintText: "Hazem Ali",
                    //alignLabelWithHint:true,

                  ),

                ),
              ),//name info
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  readOnly: true,
                   textAlign: TextAlign.end,

                  decoration: InputDecoration(

                    prefixIcon:Text(
                        "ID",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,


                      ),



                    ),


                    hintStyle:TextStyle(
                      fontSize: 20,
                      color : Colors.black,
                      //color : Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                    ),
                    //alignLabelWithHint: ,
                    hintText: "2018170135",

                    //alignLabelWithHint:true,

                  ),

                ),
              ),//id info
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.end,

                  decoration: InputDecoration(

                    prefixIcon:Text(
                      "E-mail",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),



                    ),


                    hintStyle:TextStyle(
                      fontSize: 15,
                      color : Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                    ),
                    //alignLabelWithHint: ,
                    hintText: "Hazem2018170135@cis.asu.edu.eg",
                    //alignLabelWithHint:true,

                  ),

                ),
              ),//e-mail info
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.end,

                  decoration: InputDecoration(

                    prefixIcon:Text(
                      "Date Of Birth",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),



                    ),


                    hintStyle:TextStyle(
                      fontSize: 15,
                      color : Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                    ),
                    //alignLabelWithHint: ,
                    hintText: "7 May 2000",
                    //alignLabelWithHint:true,

                  ),

                ),
              ),//birth info
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  readOnly: true,
                  textAlign: TextAlign.end,

                  decoration: InputDecoration(

                    prefixIcon:Text(
                      "Level",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),



                    ),


                    hintStyle:TextStyle(
                      fontSize: 15,
                      color : Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                    ),
                    //alignLabelWithHint: ,
                    hintText: "1",
                    //alignLabelWithHint:true,

                  ),

                ),
              ),// level info
             ],
          ),
        ),
      ),

    );
  }
}
