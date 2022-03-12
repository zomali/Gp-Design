import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class video_player extends StatefulWidget{

_video_player_state createState() => _video_player_state();

}

class _video_player_state extends State<video_player>{
String videoURL = "https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2FRevision%2C%20Variables%20%26%20Constants%20Video.mp4?alt=media&token=e71fa7c8-5082-460f-8b21-c2ad1b8ae25c";
VideoPlayerController? _controller;
 @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoURL)
    ..initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                   child: Column(
                     children: [
                        _controller!.value.isInitialized
                        ? AspectRatio(aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                    )
                    : Container(),
                     ],

                   ),
            //        Container(
              //     width: 300.0,
          //         height: 300.0,
                   
        //          ),
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
                     //       Text(
                      //        "${position.inMinutes}: ${position.inSeconds.remainder(60)}"),
                         VideoProgressIndicator(
                          _controller!,
                          allowScrubbing: true,
                          padding: EdgeInsets.all(0.0),
                          colors: const VideoProgressColors(
                           playedColor: Color.fromARGB(255, 3, 60, 126),
                           bufferedColor: Color.fromARGB(255, 238, 238, 238),
                           backgroundColor: Color.fromARGB(255, 143, 140, 140),
                          ),
                        ),                        //    Text(
                          //    "${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}"),
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
                             },//restart video
                              icon: Icon(
                                Icons.restart_alt,
                              ),
                           ),
                            IconButton(
                            onPressed:(){},
                            icon: Icon(
                            Icons.skip_previous),
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: (){
                            _controller!.value.isPlaying
                          ?_controller!.pause()
                          :_controller!.play();
                          },
                           icon: Icon(
                           Icons.play_arrow),
                          color: Colors.blue,
                           ),             
                          IconButton(
                              onPressed: (){},
                              icon: Icon(
                              Icons.skip_next),
                              color: Colors.blue,
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