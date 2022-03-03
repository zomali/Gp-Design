import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:gp/Home.dart';
import 'package:gp/Learning%20types%20screen.dart';
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
  static  List<Widget> _pages = <Widget>[
    Home(0),
    Levels(1),


    types(),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
       // backgroundColor: Colors.red,
        //    currentIndex: 0,
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize:16.5 ,


        unselectedItemColor: Colors.grey ,
        unselectedFontSize: 11,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
           // backgroundColor: Colors.blue,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            //  icon: Icon(Icons.up),
            label: 'Levels',
         //   backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.merge_type),
              label: 'Types',
          //    backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
         //     backgroundColor: Colors.blue
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
                        backgroundImage:AssetImage('proj_images/stud_image.jpg'),
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

              SizedBox(
                height: 30,
              ),

              // Row(
              //   children: [
              //     // SizedBox(
              //     //   width: 25,
              //     // ),
              //     Padding(
              //       padding: const EdgeInsets.only(left:25),
              //       child: Container(
              //         height: 120,
              //         width:150,
              //
              //         decoration: BoxDecoration(
              //           color: Colors.lime[100],
              //           borderRadius: BorderRadius.all(
              //               Radius.circular(20)
              //           ),
              //         ),
              //
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Total Course",
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 //   color : Colors.blue[600],
              //                 fontWeight: FontWeight.bold,
              //                // fontStyle: FontStyle.italic,
              //               ),
              //             ),
              //             SizedBox(
              //               height: 15,
              //             ),
              //             Text(
              //               "25",
              //               style: TextStyle(
              //                 fontSize: 30,
              //                  color : Colors.deepOrange,
              //                  fontWeight: FontWeight.bold,
              //                 // fontStyle: FontStyle.italic,
              //               ),
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right:25,left: 60),
              //       child: Container(
              //         height: 120,
              //         width:150,
              //
              //         decoration: BoxDecoration(
              //           color: Colors.cyan[100],
              //           borderRadius: BorderRadius.all(
              //               Radius.circular(20)
              //           ),
              //         ),
              //
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Complete Course",
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 //   color : Colors.blue[600],
              //                   fontWeight: FontWeight.bold,
              //                 // fontStyle: FontStyle.italic,
              //               ),
              //             ),
              //             SizedBox(
              //               height: 15,
              //             ),
              //             Text(
              //               "18",
              //               style: TextStyle(
              //                 fontSize: 30,
              //                 color : Colors.green,
              //                  fontWeight: FontWeight.bold,
              //                 // fontStyle: FontStyle.italic,
              //               ),
              //             ),
              //
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),//Course progress
              Text(
                "Completed Levels ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularPercentIndicator(
               radius: 180.0,
               lineWidth: 20.0,
               animation: true,
               percent: 0.7,
              // backgroundColor: Colors.white,
               progressColor:Colors.blue ,
               center:  Text(
                 "70.0%",
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20.0,
                 ),

               ),


               circularStrokeCap: CircularStrokeCap.round,
              // progressColor: Colors.deepOrange,
             ),




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
                    hintText: "4",
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
