import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:gp/Levels.dart';
import 'package:gp/infoDialog.dart';

class video_player extends StatefulWidget{

_video_player_state createState() => _video_player_state();

}

class _video_player_state extends State<video_player>{
  String videoURL = "https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2FRevision%2C%20Variables%20%26%20Constants%20Video.mp4?alt=media&token=e71fa7c8-5082-460f-8b21-c2ad1b8ae25c";
  String videoInfo = "Instructor: DR. Sally Saad\nDuration: 43 minutes\nLanguage: Arabic";

  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(videoURL),
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
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined, size: 20.0,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> Levels(1)));
            // _selectedIndex-=2;
            chewieController!.pause();
          },),
     ),
     body: playerWidget(),
  );
 }
}