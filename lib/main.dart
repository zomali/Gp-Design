import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Courses_evaluations_Screen.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Levels.dart';
import 'package:gp/Topic_view.dart';
import 'package:gp/edit_profile%20screen.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/shared/cubits/cubit/home_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/signup%20screen.dart';
import 'package:gp/audio_player.dart';
import 'Home.dart';
import 'classes/student.dart';
import 'Start_Quiz.dart';
import 'Levels_View.dart';

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
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
        BlocProvider(
          create: (context) => StudentBehaviorCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //home: Edit_Proile_Screen(),
        //home:levels_view(student),
        //home:Start_Quiz(),

        // home: MyProfileScreen(),
        home: Login_screen(),
        // home: Home(0),
        //home: Courses_evaluations_Screen(new student()),
        //home: signup_screen(),
        // home: audio_player(),
      ),
    );
  }
}
