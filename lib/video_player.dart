import 'package:flutter/material.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:gp/Levels.dart';
import 'package:gp/infoDialog.dart';

class video_player extends StatefulWidget {
  final student std;
  final ForVideo forVideo;
  final Video_ video;
  video_player(this.std, this.video, this.forVideo);
  _video_player_state createState() => _video_player_state(std, video, forVideo);
}

class _video_player_state extends State<video_player> {
  student std;
  ForVideo forVideo;
  Video_ video;
  _video_player_state(this.std, this.video, this.forVideo);

  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(video.URL),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: false,
        looping: true,
        errorBuilder: (context, ErrorSummary) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ErrorSummary,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          );
        },
        additionalOptions: (context) {
          return <OptionItem>[
            OptionItem(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => infoDialog(
                          title: "Video Info",
                          description: "Instructor: "+ video.source +"\nDuration: " + video.duration +"\nLanguage: " + video.language,
                          buttonText: "Ok"));
                },
                iconData: Icons.info_outline,
                title: "Info"),
          ];
        });
  }

  @override
  void dispose() {
    chewieController!.videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  Chewie playerWidget() {
    return Chewie(controller: chewieController!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          video.title,
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Levels(1, student())));
            // _selectedIndex-=2;
            chewieController!.pause();
          },
        ),
      ),
      body: playerWidget(),
    );
  }
}
