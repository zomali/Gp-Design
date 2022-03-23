// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gp/Levels.dart';
import 'package:gp/infoDialog.dart';
class audio_player extends StatefulWidget {
  _audio_player_state createState() => _audio_player_state();
}

class _audio_player_state extends State<audio_player> {
  String URL =
      "https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FArabic%2Fvariable%20and%20constans.mp3?alt=media&token=d44db750-cb81-4589-8f1d-f3561f870804";
  // String topicName = "Revision, Varriables & Constants";
  // String audioInfo = "Instructor: DR. Sally Saad\nDuration: 43 minutes\nLanguage: Arabic";

  int topicID = 1; //will be passed from the previous page
  String audioLanguage = "Arabic"; //passed from previous page?

  var audio;
  bool playing = false;
  bool muted = false;
  double volume = 80;
  IconData volumeBtn = Icons.volume_up;
  IconData playBtn = Icons.play_arrow;
  AudioPlayer _player = new AudioPlayer();
  AudioCache cache = new AudioCache();
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        value: position.inSeconds.toDouble(),
        min: 0.0,
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    cache = AudioCache(fixedPlayer: _player);
    //get audio duration
    _player.onDurationChanged.listen((d) {
      setState(() {
        musicLength = d;
      });
    });
    //get cursor position
    _player.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    _player.setUrl(URL);
    _player.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Revision, Variables & Constants",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 3, 60, 126),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Levels(1)));
            _player.pause();
            // _selectedIndex-=2;
          },
        ),
      ),
      body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 3, 60, 126),
                        Colors.blue[200]!,
                      ]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 48.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.0,
                        ),
                        Center(
                          child: Container(
                            width: 300.0,
                            height: 300.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://play-lh.googleusercontent.com/RF9eZ6QIf8nW5iQLKgYd05yNqM1kTMfIxJZZhQHrsJu_uaeRKDrpaEBOy-NDUpC2xw'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 46.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 550.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${position.inMinutes} : ${position.inSeconds.remainder(60)}"),
                                      slider(),
                                      Text(
                                          "${musicLength.inMinutes} : ${musicLength.inSeconds.remainder(60)}"),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 30.0,
                                      color: Colors.blue,
                                      onPressed: () {
                                        position = new Duration(seconds: 0);
                                        _player.seek(position);
                                      }, //restart audio
                                      icon: Icon(
                                        Icons.restart_alt,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 40.0,
                                      color: Colors.blue,
                                      onPressed: () {
                                        position = position - Duration(seconds: 10);
                                        if (position >= Duration(seconds: 0))
                                          _player.seek(position);
                                        else {
                                          _player.seek(Duration(seconds: 0));
                                        }
                                      }, //replay previous 10 secs
                                      icon: Icon(
                                        Icons.replay_10_rounded,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 62.0,
                                      color: Colors.blue[800],
                                      onPressed: () {
                                        if (!playing) {
                                          _player.play(audio!.URL);
                                          setState(() {
                                            playBtn = Icons.pause;
                                            playing = true;
                                          });
                                        } else {
                                          _player.pause();
                                          setState(() {
                                            playBtn = Icons.play_arrow;
                                            playing = false;
                                          });
                                        }
                                      }, //play audio of current topic
                                      icon: Icon(
                                        playBtn,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 40.0,
                                      color: Colors.blue,
                                      onPressed: () {
                                        position = position + Duration(seconds: 10);
                                        if (position <= musicLength)
                                          _player.seek(position);
                                        else {
                                          _player.seek(musicLength);
                                        }
                                      }, //forward 10 secs
                                      icon: Icon(
                                        Icons.forward_10_rounded,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 30.0,
                                      color: Colors.blue,
                                      onPressed: () {
                                        String audioInfo = "Instructor: " +
                                            audio!.source +
                                            "\nDuration: " +
                                            audio!.duration +
                                            "\nLanguage: " +
                                            audio!.language;
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                infoDialog(
                                                    title: "Audio Information",
                                                    description: audioInfo,
                                                    buttonText: "OK"));
                                      }, //view audio info
                                      icon: Icon(
                                        Icons.info_outline,
                                      ),
                                    ),
                                  ],
                                ),
                               
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),      
    );
  }
}
