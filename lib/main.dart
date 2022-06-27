import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:gp/Login_scrn.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'package:gp/shared/cubits/cubit/level_cubit.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';
import 'package:gp/shared/cubits/cubit/quiz_cubit.dart';
import 'package:gp/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseCubit(),
        ),
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
        BlocProvider(
          create: (context) => StudentBehaviorCubit(),
        ),
        BlocProvider(
          create: (context) => LevelCubit(),
        ),
        BlocProvider(
          create: (context) => TopicCubit(),
        ),
        BlocProvider(
          create: (context) => QuestionCubit(),
        ),
        BlocProvider(
          create: (context) => QuizCubit(),
        ),
        
      ],
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: AnimatedSplashScreen(
      //     splash: Center(
      //       child: Column(
      //         children: [
      //                                  CircleAvatar(
      //                                    radius: 50,
      //                                    child: Container(
      //                                    //  width: MediaQuery.of(context).size.width,
      //                                 //    height: MediaQuery.of(context).size.height,
      //                                     decoration: BoxDecoration(
      //                                       image: DecorationImage(
      //                                         image:
      //                                             AssetImage('proj_images/photo.jpg'),
      //                                         fit: BoxFit.fill,
      //                                       ),
      //                                     ),
      //                                 ),
      //                                  ),
      //         ],
      //       ),
      //     ), splashTransition: SplashTransition.fadeTransition,
      //            //pageTransitionType: PageTransitionType.scale,
      //            duration: 10000,
      //           nextScreen: MyLogin()
      //   ),
      //   ),
      //),
      // child: MaterialApp(
      //  // title: 'Personalized E-Learning System',
      //   debugShowCheckedModeBanner: false,
      //   home: SingleChildScrollView(
      //     child: Container(
      //       color: Colors.white,
      //       height:700,
      //       width: double.infinity,
      //       child: AnimatedSplashScreen(
      //       //  centered : true,
      //       splash: Column(
      //        // mainAxisAlignment: MainAxisAlignment.start,
      //          // crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                Spacer(),
      //                 CircleAvatar(
      //                       radius: 40,
      //                       backgroundColor: Colors.white,
      //                       child: Container(
      //                         height: 100,
      //                          width: 100,
      //                         decoration: BoxDecoration(
      //                           image: DecorationImage(
      //                             image:
      //                                 AssetImage('proj_images/Ain_Shams_logo.png'),
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     // Padding(
      //                     //       padding: EdgeInsets.all(5),
      //                     //       //height: 60,
      //                     //       child: VerticalDivider(
      //                     //       color: Colors.blueGrey[200],
      //                     //       width: 20,
      //                     //       thickness: 2,
      //                     //       indent: 5,
      //                     //       endIndent: 5,
      //                     //         ),
      //                     //    ),
      //               //  Spacer(),
      //                 SizedBox(width: 40,),
      //                     CircleAvatar(
      //                       radius: 40,
      //                       backgroundColor: Colors.white,
      //                       child: Container(
      //                         width:150,
      //                         height: 150,
      //                         decoration: BoxDecoration(
      //                           image: DecorationImage(
      //                             image:
      //                                 AssetImage('proj_images/fcis.png'),
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                 Spacer(),
      //
      //               ],
      //             ),
      //             //Spacer(),
      //             SizedBox(height: 60,),
      //             Text('Personalized E-learning System', style: TextStyle(color: Colors.blueGrey, ),),
      //             Text('2022', style: TextStyle(color: Colors.blueGrey[200], ),),
      //             Spacer(),
      //           ],
      //         ),
      //
      //
      //
      //    // splashTransition: SplashTransition.fadeTransition,
      //       //pageTransitionType: PageTransitionType.scale,
      //       duration: 5000,
      //       nextScreen: MyLogin()),
      //     ),
      //   ),
      //  //home: Login_screen(),
      //  //
      // ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splash_screen(),
      ),
      //child: MyLogin(),

    );

  }
}
