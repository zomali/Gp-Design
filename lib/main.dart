import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'package:gp/shared/cubits/cubit/level_cubit.dart';
import 'package:gp/shared/cubits/cubit/question_cubit.dart';
import 'package:gp/shared/cubits/cubit/quiz_cubit.dart';

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
      
      child: MaterialApp(
        title: 'Personalized E-Learning System',
        debugShowCheckedModeBanner: false,
        //home: Edit_Proile_Screen(),
        //home:Start_Quiz("1"),
        //home:QuizResults("1"),
        // home: MyProfileScreen(),
        home: Login_screen(),
        //home: side_layout(),
        //home: Menu_SideBar(),
        // home: Home(0),
        //home: Courses_evaluations_Screen(new student()),
        //home: signup_screen(),
      ),
    );
  }
}
