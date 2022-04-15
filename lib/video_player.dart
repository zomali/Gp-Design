import 'package:flutter/material.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:gp/infoDialog.dart';
class video_player extends StatefulWidget {
  final student std;
  final Video_ video_;
  final ForVideo forVideo;
  final Level_ level;
  final Topic_ topic;
  video_player(this.std, this.video_, this.forVideo, this.level, this.topic);
  _video_player_state createState() => _video_player_state(std, video_, forVideo, level, topic);
}
class _video_player_state extends State<video_player> {
  student std;
  Video_ video_;
  ForVideo forVideo;
  Level_ level;
  Topic_ topic;
  _video_player_state(this.std, this.video_, this.forVideo, this.level, this.topic);
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(video_.URL),
        aspectRatio: 16/9,
        autoInitialize: true,
        autoPlay: false,
        looping: true,
        errorBuilder: (context, ErrorSummary){
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ErrorSummary,
                  style: TextStyle(color: Colors.white,)),
            ),
          );
        },
        additionalOptions: (context){
          return <OptionItem>[
            OptionItem(
                onTap: (){
                  String videoInfo = "Instructor:" + video_.source + "\nDuration:" + video_.duration + "\nLanguage:" + video_.language;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          infoDialog(
                              title: "Video Info",
                              description: videoInfo,
                              buttonText: "Ok"));
                },
                iconData: Icons.info_outline,
                title: "Info"),
          ];
        }
    );

  }
  @override
  void dispose() {
    chewieController!.videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  Chewie playerWidget(){
    return Chewie(
        controller: chewieController!);
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
            // _selectedIndex-=2;
            chewieController!.pause();
          },
        ),
      ),
      body: playerWidget(),
    );
  }
}
