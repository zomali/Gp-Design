import 'package:flutter/material.dart';
import 'package:gp/Login_scrn.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return new  AnimatedSplashScreen(


       duration: 4000,
       splash:  Container(
         width: 150,
         height: 800,
         child: Image(
           fit: BoxFit.fill,
               //fit: BoxFit.contain,
               image:AssetImage("proj_images/app_icon.jpg"),
             ),
       ),


       //nextScreen: MainScreen(),
       splashTransition: SplashTransition.rotationTransition,
      // pageTransitionType: PageTransition,
       backgroundColor: Colors.white,
     nextScreen: new MyLogin(),
      //seconds: 6,
      // navigateAfterSeconds: new MyLogin(),
      // title: new Text('GeeksForGeeks',textScaleFactor: 2,),
      // image: new,
      // loadingText: Text("Loading"),
      // photoSize: 100.0,
      // loaderColor: Colors.blue,
    );
  }
}
