import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Last_quizes.dart';
class Subject_lastQuizes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text("Personalized E-learning System"),
    leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_outlined),
    onPressed: () {}
      ) ,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(

            children: [

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                GestureDetector(
                  onTap: (){
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => lastQuizes();
                  },
                  child: Container(

                    width: 150.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image(image: AssetImage('proj_images/cc.png')),
                        Container(
                          width: 200.0,
                          color:  Colors.black.withOpacity(0.7),

                          padding:EdgeInsets.symmetric(
                            vertical: 10.0
                          ),
                          child: Text(
                            'SP Quizes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,

                            ),
                          ),
                        )

                      ],
                    ),

                  ),
                ),
                    SizedBox(
                    width: 30.0,
                    ),


                    GestureDetector(
                      child: Container(

                        width: 200.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image(image: AssetImage('proj_images/m.jpg')),
                            Container(
                              width: 200.0,
                              color:  Colors.black.withOpacity(0.7),

                              padding:EdgeInsets.symmetric(
                                  vertical: 10.0
                              ),
                              child: Text(
                                'Math 2 Quizes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,

                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                    ),


                  ] ,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    GestureDetector(
                      child: Container(

                        width: 150.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image(image: AssetImage('proj_images/p.png')),
                            Container(
                              width: 200.0,
                              color:  Colors.black.withOpacity(0.7),

                              padding:EdgeInsets.symmetric(
                                  vertical: 10.0
                              ),
                              child: Text(
                                'Physics 2 Quizes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,

                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    GestureDetector(
                      child: Container(

                        width: 170.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image(image: AssetImage('proj_images/en.jpg')),
                            Container(
                              width: 200.0,
                              color:  Colors.black.withOpacity(0.7),

                              padding:EdgeInsets.symmetric(
                                  vertical: 10.0
                              ),
                              child: Text(
                                'English 2 Quizes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,

                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                    ),


                  ] ,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    GestureDetector(
                      child: Container(

                        width: 180.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image(image: AssetImage('proj_images/electronics.png')),
                            Container(
                              width: 200.0,
                              color:  Colors.black.withOpacity(0.7),

                              padding:EdgeInsets.symmetric(
                                  vertical: 10.0
                              ),
                              child: Text(
                                'Electronics Quizes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,

                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    GestureDetector(
                      child: Container(

                        width: 180.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image(image: AssetImage('proj_images/business.jpg')),
                            Container(
                              width: 200.0,
                              color:  Colors.black.withOpacity(0.7),

                              padding:EdgeInsets.symmetric(
                                  vertical: 10.0
                              ),
                              child: Text(
                                'Business Quizes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,

                                ),
                              ),
                            )

                          ],
                        ),

                      ),
                    ),

                  ] ,
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
