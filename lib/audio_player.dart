import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp/audio_player.dart';
import 'package:gp/Levels.dart';
class audio_player extends StatefulWidget{

_audio_player_state createState() => _audio_player_state();

}

class _audio_player_state extends State<audio_player>{

  bool playing = false;
  IconData playBtn = Icons.play_arrow;
  AudioPlayer _player = new AudioPlayer();
  AudioCache cache = new AudioCache();
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider(){
    return Slider.adaptive(
      activeColor: Colors.blue[800],
      inactiveColor: Colors.grey[350],
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      });
  }
  void seekToSec(int sec){
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState(){
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
    _player.setUrl("https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FArabic%2Fvariable%20and%20constans.mp3?alt=media&token=d44db750-cb81-4589-8f1d-f3561f870804");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,

        backgroundColor: Color.fromARGB(255, 3, 60, 126),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            //   _player.pause();
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Levels(1)));
            _player.pause();
            // _selectedIndex-=2;

          },),

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
            padding: EdgeInsets.only(top: 48.0
            ),
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
                            image: NetworkImage('https://play-lh.googleusercontent.com/RF9eZ6QIf8nW5iQLKgYd05yNqM1kTMfIxJZZhQHrsJu_uaeRKDrpaEBOy-NDUpC2xw'),
                        ),
                   ),
                  ),
                ),
           
               SizedBox(height: 18.0,),
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
                              onPressed:() {
                              position = new Duration(seconds: 0);
                              _player.seek(position);
                              },//restart audio
                              icon: Icon(
                                Icons.restart_alt,
                              ),
                           ),
                           IconButton(
                              iconSize: 40.0,
                              color: Colors.blue,
                              onPressed:() {

                              },//previous topic audio
                              icon: Icon(
                                Icons.skip_previous,
                              ),
                           ),
                           
                            IconButton(
                              iconSize: 62.0,
                              color: Colors.blue[800],
                              onPressed:() {
                                if(!playing)
                                {
                                  _player.play("https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FArabic%2Fvariable%20and%20constans.mp3?alt=media&token=d44db750-cb81-4589-8f1d-f3561f870804");
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                }
                                else
                                {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },//play audio of current topic
                              icon: Icon(
                                playBtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 40.0,
                              color: Colors.blue,
                              onPressed:() {

                              },//next topic audio
                              icon: Icon(
                                Icons.skip_next,
                              ),
                           ),
                           IconButton(
                              iconSize: 30.0,
                              color: Colors.blue,
                              onPressed:() {},//view audio info
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