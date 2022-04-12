import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Home.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/Topic_view.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'package:path/path.dart';
import 'audio_player.dart';
import 'video_player.dart';
import 'package:gp/URL_view.dart';
import 'classes/student.dart';
import 'classes/classes.dart';
import 'topic_images.dart';
import 'pdf_view.dart';
import 'Levels_View.dart';

class types extends StatefulWidget {
  final student std;
  final Level_ level;
  final Topic_ topic;
  types(this.std, this.level, this.topic);
/*
  int _selectedIndex = 3;
  static List<Widget> _pages = <Widget>[
    Home(student()),
    levels_view(student()),
    types(student(), 0, 0),
    MyProfileScreen(student()),
  ];
*/
  @override
  _typesState createState() => _typesState(std, level, topic);
}

class _typesState extends State<types> {
  student std;
  Level_ level;
  Topic_ topic;
  _typesState(this.std, this.level, this.topic);
  late studentBehavior stdBehavior;
  //late TypesForStudent list;
  var cupit;
  bool _video_1st = true;
  //bool _video_1st=false;

  bool _audio_1st = false;
//  bool _audio_1st=true;

  bool _text_1st = false;
  // bool _text_1st=true;

  bool _image_1st = false;
// bool _image_1st=true;

//Topic_ topic  = Topic_();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 30,
          title: Text("Personalized E-learning System"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => topic_view(std, level)));
              // _selectedIndex-=2;
            },
          ),
        ),
        body: Builder(builder: (context) {
          StudentBehaviorCubit.get(context)
              .getTimeSpendEveryOnce(std.id, level.id, topic.id);
          return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
            builder: (context, state){
              if(state is StudentBehaviorLoading)
              {
                return Center(child: CircularProgressIndicator());
              }
              else {
                var behaviorCubit = StudentBehaviorCubit.get(context);
                stdBehavior = behaviorCubit.value;
                TopicCubit.get(context).getTopicData(topic.id);
                return BlocBuilder<TopicCubit, TopicState>(
                builder: (context, state) {
                  if (state is TopicLoading)
                    return Center(child: CircularProgressIndicator());
                  else {
                    var topicCubit = TopicCubit.get(context);
                    var topic = topicCubit.topic;
                    //stdBehavior = behaviorCubit.std;
                    return Center(
                      child: Container(
                        color: Colors.blue[200],
                        // height: double.infinity,
                        //  height: 620,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  print("'Clicked'"),
          
                                  // print(
                                  //     stdBehavior.forAudio.Time_spent_every_once[1])
                                },
                                child: Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Image(
                                        image: _video_1st
                                            ? AssetImage('proj_images/video.png')
                                            : _audio_1st
                                                ? AssetImage(
                                                    'proj_images/audio.png')
                                                : _image_1st
                                                    ? AssetImage(
                                                        'proj_images/image.png')
                                                    : AssetImage(
                                                        'proj_images/Text.png'),
                                        height: 250,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        color: Colors.black.withOpacity(.7),
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10.0),
                                        child: Text(
                                          _video_1st
                                              ? "Video"
                                              : _audio_1st
                                                  ? 'Audio'
                                                  : _image_1st
                                                      ? 'Image'
                                                      : 'Text',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //new fun
                              ////////////////////////////////////////////////////////////////
                              //        SingleChildScrollView(
                              //       scrollDirection: Axis.horizontal,
                              //    child:
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => audio_player(
                                                    std,
                                                   topic.audios[0],
                                                    stdBehavior.forAudio,
                                                    level,
                                                    topic)),
                                          ),
                                        },
                                        //print("'Clicked'")},
                                        child: Container(
                                          //   height: 100,
          
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Image(
                                                image: _video_1st
                                                    ? AssetImage(
                                                        'proj_images/audio.png')
                                                    : _audio_1st
                                                        ? AssetImage(
                                                            'proj_images/video.png')
                                                        : _image_1st
                                                            ? AssetImage(
                                                                'proj_images/video.png')
                                                            : AssetImage(
                                                                'proj_images/video.png'),
                                                height: 110,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                color: Colors.black.withOpacity(.7),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text(
                                                  _video_1st
                                                      ? "Audio"
                                                      : _audio_1st
                                                          ? 'Video'
                                                          : _image_1st
                                                              ? 'Video'
                                                              : 'Video',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      //////////////////////////////////////////////////////////////////////
                                      GestureDetector(
                                        onTap: () => {
                                          print("'Clicked'"),
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => image_view(
                                                    std,
                                                    topic.images,
                                                    stdBehavior.forImage,
                                                    level,
                                                    topic)),
                                          ),
                                        },
                                        child: Container(
                                          //  padding: EdgeInsets.only(top: 10.0),
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Image(
                                                image: _video_1st
                                                    ? AssetImage(
                                                        'proj_images/image.png')
                                                    : _audio_1st
                                                        ? AssetImage(
                                                            'proj_images/image.png')
                                                        : _image_1st
                                                            ? AssetImage(
                                                                'proj_images/audio.png')
                                                            : AssetImage(
                                                                'proj_images/audio.png'),
                                                //   height: 250,
                                                //  width: 250,
                                                height: 110,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                color: Colors.black.withOpacity(.7),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text(
                                                  _video_1st
                                                      ? "Image"
                                                      : _audio_1st
                                                          ? 'Image'
                                                          : _image_1st
                                                              ? 'Audio'
                                                              : 'Audio',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
          
                                      ///////////////////////////////////////////////////////
                                      GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => pdf_view(
                                                    std,
                                                    topic.pdf,
                                                    stdBehavior.forText,
                                                    level,
                                                    topic)),
                                          ),
                                        },
                                        child: Container(
                                          //  padding: EdgeInsets.only(top: 10.0),
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Image(
                                                image: _video_1st
                                                    ? AssetImage(
                                                        'proj_images/Text.png')
                                                    : _audio_1st
                                                        ? AssetImage(
                                                            'proj_images/Text.png')
                                                        : _image_1st
                                                            ? AssetImage(
                                                                'proj_images/Text.png')
                                                            : AssetImage(
                                                                'proj_images/image.png'),
                                                height: 110,
                                                // height: 250,
                                                //    width: 250,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                color: Colors.black.withOpacity(.7),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                child: Text(
                                                  _video_1st
                                                      ? "Text"
                                                      : _audio_1st
                                                          ? 'Text'
                                                          : _image_1st
                                                              ? 'Text'
                                                              : 'Image',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
              }
            }
          );
        })
        
        );
  }
}
