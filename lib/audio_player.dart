import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/infoDialog.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/studentBehavior.dart';

class audio_player extends StatefulWidget {
  final student std;
  final ForAudio forAudio;
  final Audio_ audio;
  final int LevelNumber;
  final int TopicNumber;
  audio_player(this.std,this.audio, this.forAudio, this.LevelNumber, this.TopicNumber);
  _audio_player_state createState() =>
      _audio_player_state(std, audio, forAudio, LevelNumber, TopicNumber);
}

class _audio_player_state extends State<audio_player> {
  student std;
  ForAudio forAudio;
  Audio_ audio;
  int LevelNumber;
  int TopicNumber;
  _audio_player_state(
      this.std,this.audio, this.forAudio, this.LevelNumber, this.TopicNumber);
  bool playing = false;
  List<int> times = [];
  int i = 0;
  int NumperOfEnters = 0;
  IconData playBtn = Icons.play_arrow;
  AudioPlayer _player = new AudioPlayer();
  AudioCache cache = new AudioCache();
  Duration position = new Duration();
  Duration musicLength = new Duration();
  DatabaseManager db = DatabaseManager();

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        value: position.inSeconds.toDouble(),
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
    _player.setUrl(
        "https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FArabic%2Fvariable%20and%20constans.mp3?alt=media&token=d44db750-cb81-4589-8f1d-f3561f870804");
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialTime = DateTime.now();
    final initialHour = initialTime.hour.toString().padLeft(2, '0');
    final initialMinute = initialTime.minute.toString().padLeft(2, '0');
    final initialSecond = initialTime.second.toString().padLeft(2, '0');

    String x = '$initialHour$initialMinute$initialSecond';
    int firstTime = int.parse(x);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color.fromARGB(255, 3, 60, 126),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            DateTime FinalTime = DateTime.now();
            final FinalHour = FinalTime.hour.toString().padLeft(2, '0');
            final FinalMinute = FinalTime.minute.toString().padLeft(2, '0');
            final FinalSecond = FinalTime.second.toString().padLeft(2, '0');
            x = '$FinalHour$FinalMinute$FinalSecond';
            int SecondTime = int.parse(x);
            int timeStayed = SecondTime - firstTime;
            ForAudio NewforAudio = ForAudio();

            for (i = 0; i < 100; i++) {
              try {
                times.add(forAudio.Time_spent_every_once[i]);
                NumperOfEnters++;
              } catch (e) {
                times.add(timeStayed);
                break;
              }
            }

            NewforAudio.NumberOfVisitedPage = forAudio.NumberOfVisitedPage + 1;
            NewforAudio.TimeSpendInPage =
                forAudio.TimeSpendInPage + (SecondTime - firstTime);
            db.updateStudentBehavior(
              NewforAudio.TimeSpendInPage,
              NewforAudio.NumberOfVisitedPage,
              "audio",
              std.id,
              LevelNumber,
              TopicNumber,
              times,
            );

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => levels_view(std)));
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
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Revision, Varriables & Constants",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
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
                  height: 18.0,
                ),
                SizedBox(),
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
                          width: 450.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${position.inMinutes}: ${position.inSeconds.remainder(60)}"),
                              slider(),
                              Text(
                                  "${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}"),
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
                                          _player.play(audio.URL);
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
                                            audio.source +
                                            "\nDuration: " +
                                            audio.duration +
                                            "\nLanguage: " +
                                            audio.language;
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
                        )
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
