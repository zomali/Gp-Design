import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Levels.dart';
import 'package:gp/URL_view.dart';
import 'package:gp/edit_profile%20screen.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/pdf_view.dart';
import 'package:gp/shared/cubits/cubit/home_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/student_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'package:gp/shared/cubits/cubit/level_cubit.dart';
import 'package:gp/signup%20screen.dart';
import 'package:gp/audio_player.dart';
import 'package:gp/topic_images.dart';
import 'Home.dart';
import 'start_quiz_view.dart';

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
          create: (context) => TopicCubit(),
        ),
        BlocProvider(
          create: (context) => LevelCubit(),
        ),
        BlocProvider(
          create: (context) => StudentBehaviorCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Edit_Proile_Screen(),
        // home: MyProfileScreen(),
        home: Login_screen(),
        //home:Start_quiz(),
        // home: Home(0),
        // home: types(),
        //home: signup_screen(),
        // home: audio_player(),
      ),
    );
  }
}
