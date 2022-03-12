import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class video_player extends StatefulWidget{

_video_player_state createState() => _video_player_state();

}

class _video_player_state extends State<video_player>{
String videoURL = "https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2FRevision%2C%20Variables%20%26%20Constants%20Video.mp4?alt=media&token=e71fa7c8-5082-460f-8b21-c2ad1b8ae25c";
VideoPlayerController? _controller;
Color mainColor = Colors.blue[800]!;
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
     backgroundColor: mainColor,
     appBar: AppBar(
       backgroundColor: mainColor,
       elevation: 0.0,
       title: Text("Video Player"),
     ),
     body: Column(
       children: [
         _controller!.value.isInitialized
         ? AspectRatio(aspectRatio: _controller!.value.aspectRatio,
         child: VideoPlayer(_controller!),
         )
         : Container(),
         VideoProgressIndicator(
           _controller!,
          allowScrubbing: true,
          padding: EdgeInsets.all(0.0),
          colors: const VideoProgressColors(
            playedColor: Color.fromARGB(255, 3, 60, 126),
            bufferedColor: Color.fromARGB(255, 238, 238, 238),
            backgroundColor: Color.fromARGB(255, 143, 140, 140),
          ),
          ),
         Row(
           children: [
             IconButton(
               onPressed: (){},
               icon: Icon(
                 Icons.skip_previous),
                 color: Colors.white,
                 ),
              IconButton(
               onPressed: (){
                 _controller!.value.isPlaying
                 ?_controller!.pause()
                 :_controller!.play();
               },
               icon: Icon(
                 Icons.play_arrow),
                 color: Colors.white,
                 ),             
              IconButton(
               onPressed: (){},
               icon: Icon(
                 Icons.skip_next),
                 color: Colors.white,
                 ),
                ],
              ),
       ],
     ),
        );
  }
}
