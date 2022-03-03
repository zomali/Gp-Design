import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Learning types screen.dart';
import 'Levels.dart';
import 'Types.dart';
//import 'package:flutter_application_1/levels.dart';

class Home extends StatefulWidget {

  final int ind;
  Home(this.ind);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(widget.ind),
    );
  }
}

class HomePage extends StatefulWidget {

  int ind=0;
  HomePage(this.ind);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
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

  Widget _selectedCleaning(
      @required Color color,
      @required String title,
      @required String supTitle){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const EdgeInsets.only(left: 20,),
      height: 120,
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius:BorderRadius.circular(15.0),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style:const TextStyle(
              fontSize: 22,color: Colors.white
          ),),
          const SizedBox(
            height: 5,
          ),
          Text(supTitle,style:const TextStyle(
              fontSize: 19,color: Colors.white70
          ),)
        ],
      ),
    );
  }

  Widget _selectedSPImage(){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const EdgeInsets.only(left: 10,),
      height: 220,
      width: 440,
      decoration: BoxDecoration(
        image:const DecorationImage(
            image: AssetImage('proj_images/login_image.jpeg'),
            fit: BoxFit.cover
        ),
        borderRadius:BorderRadius.circular(15.0),

      ),
    );
  }

  Widget _outcomes(@required Color color,@required String title){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const EdgeInsets.only(left: 20),
      height: 40,
      width: 440,
      decoration: BoxDecoration(
        color: color,
        borderRadius:BorderRadius.circular(15.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style:const TextStyle(
                fontSize: 22,color: Colors.white
            ),),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,

          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title:const Text("Home page"),
            leading:const Icon(Icons.home),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize:16.5 ,


        unselectedItemColor: Colors.grey ,
        unselectedFontSize: 11,

        //    currentIndex: 0,
            items:const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  //backgroundColor: Colors.blue,
             //   backgroundColor: Colors.blue,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
              //  icon: Icon(Icons.up),
                  label: 'Levels',
                 // backgroundColor: Colors.blue,
           //     backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.merge_type),
                  label: 'Types',
                //  backgroundColor: Colors.blue
            //    backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
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
          body:  Container(
              height: 800,
              width: double.infinity,
              decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  )
              ),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30,top: 30),
                    child: Text("Progress",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ) ,),
                  ),

                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child:Padding(padding:const EdgeInsets.only(left: 30,top: 30,
                  //   ),
                  //     child: Row(
                  //       children: [
                  //         _selectedCleaning(
                  //             Theme.of(context).colorScheme.secondary,
                  //             'Current Level',
                  //             '${widget.ind}'
                  //         ),
                  //         _selectedCleaning(
                  //             Theme.of(context).colorScheme.secondary,
                  //             'Number of Levels',
                  //             '30'
                  //         )
                  //       ],
                  //     ),
                  //   ) ,
                  // ),//progress

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 30.0,
                        animationDuration: 2000,
                        percent: 0.7,
                        center: Text("70.0%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ),

                  Container(
                    padding:const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text('Structured Programming',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(
                              top: 10
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:Padding(padding:const EdgeInsets.only(left: 5,top: 15,
                              ),
                                child: Row(
                                  children: [
                                    _selectedSPImage()
                                  ],
                                ),
                              )
                          ),
                        )
                      ],),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 30,top: 10),
                    child: Text("Learning Outcomes",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ) ,),
                  ),

                 Padding(padding:const EdgeInsets.only(left: 18,top: 20,right: 10,
                    ), //outcomes
                      child: Column(

                        children: [
                          _outcomes(
                              Theme.of(context).colorScheme.secondary,
                              'Learn from the beginning'
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10,),),
                          _outcomes(
                              Theme.of(context).colorScheme.secondary,
                              'Many types of Learning'
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10,),),
                          _outcomes(
                              Theme.of(context).colorScheme.secondary,
                              'Quiz after each level'
                          ),
                        ],
                      ),//outcomes
                    ),

                  const Padding(
                    padding: EdgeInsets.only(left: 30,top: 30),
                    child: Text("Instructors",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ) ,),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:Padding(padding:const EdgeInsets.only(left: 18,top: 30,
                    ),
                      child: Row(
                        children: [
                          _selectedCleaning(
                              Theme.of(context).colorScheme.secondary,
                              'Dr.Sally',
                              'Sally@gmail.com'
                          ),
                          _selectedCleaning(
                              Theme.of(context).colorScheme.secondary,
                              'Dr.Yasmin',
                              'Yasmin@gmail.com'
                          ),
                          _selectedCleaning(
                              Theme.of(context).colorScheme.secondary,
                              'Dr.Yasmin',
                              'Yasmin@gmail.com'
                          )
                        ],

                      ),
                    ) ,
                  ),//instructors
                  const Padding(padding: EdgeInsets.only(bottom: 10,),),
                ],
              ),
            ),
          ),
        );
  }
}