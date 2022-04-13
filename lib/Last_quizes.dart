import 'package:flutter/material.dart';

import 'Sidebar/BlockNavigation.dart';
class lastQuizes extends StatefulWidget with NavigationStates{


  @override
  State<lastQuizes> createState() => _lastQuizesState();
}

class _lastQuizesState extends State<lastQuizes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Archive"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {},
        ),
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            GestureDetector(
              onTap: (){print('clicked 1');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The First Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 2');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Second Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 3 ');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Third Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 4');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,

                        ),
                        child: Text(
                          'The Fourth Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){print('clicked 5');},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(
                          20.0
                      ),
                    ),


                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(image: NetworkImage('https://wallpapercave.com/wp/wp2555194.png'),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.6),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'The Fifth Quize',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,

                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],

        ),
      ),




    );
  }
}