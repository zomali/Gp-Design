import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'package:gp/shared/cubits/cubit/level_cubit.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';
import 'package:gp/shared/cubits/cubit/quiz_cubit.dart';
import 'package:gp/shared/cubits/cubit/weakness_topics_cubit.dart';

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
        BlocProvider(
          create: (context) => WeaknessTopicsCubit(),
        ),
      ],
      
      child: MaterialApp(
        title: 'Personalized E-Learning System',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          centered : true,
        splash: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
            child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('proj_images/Ain_Shams_logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                            padding: EdgeInsets.all(5),
                            //height: 60,
                            child: VerticalDivider(
                            color: Colors.blueGrey[200],
                            width: 20,
                            thickness: 2,
                            indent: 5,
                            endIndent: 5,
                              ),
                         ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('proj_images/fcis.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
              SizedBox(height: 60,),
              Text('Personalized E-learning System', style: TextStyle(color: Colors.blueGrey, ),),
              Text('2022', style: TextStyle(color: Colors.blueGrey[200], ),)
            ],
          ),
        ),
          ),
        ),
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.scale,
        duration: 2500,
        nextScreen: Login_screen()),
        //home: Login_screen(),

      ),
    );
  }
}
