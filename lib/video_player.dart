import 'package:flutter/material.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/classes.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:gp/dialogs/infoDialog.dart';
import 'DatabaseManager.dart';
import 'L_types.dart';

class video_player extends StatefulWidget {
  final student std;
  final Video_ video_;
  final ForVideo forVideo;
  final Level_ level;
  final Topic_ topic;
  video_player(this.std, this.video_, this.forVideo, this.level, this.topic);
  _video_player_state createState() =>
      _video_player_state(std, video_, forVideo, level, topic);
}

class _video_player_state extends State<video_player> {
  student std;
  Video_ video_;
  ForVideo forVideo;
  Level_ level;
  Topic_ topic;
  _video_player_state(
      this.std, this.video_, this.forVideo, this.level, this.topic);
  ChewieController? chewieController;
  List<int> times = [];
  int i = 0;
  int NumperOfEnters = 0;
  DatabaseManager db = DatabaseManager();
  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(video_.URL),
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
                  String videoInfo = "Instructor:" +
                      video_.source +
                      "\nDuration:" +
                      video_.duration +
                      "\nLanguage:" +
                      video_.language;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => infoDialog(
                          title: "Video Info",
                          description: videoInfo,
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
    DateTime initialTime = DateTime.now();
    final initialHour = initialTime.hour.toString().padLeft(2, '0');
    final initialMinute = initialTime.minute.toString().padLeft(2, '0');
    final initialSecond = initialTime.second.toString().padLeft(2, '0');

    String x = '$initialHour$initialMinute$initialSecond';
    int firstTime = int.parse(x);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          video_.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1565C0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20.0,
          ),
          onPressed: () {
            // _selectedIndex-=2;
            DateTime FinalTime = DateTime.now();
            final FinalHour = FinalTime.hour.toString().padLeft(2, '0');
            final FinalMinute = FinalTime.minute.toString().padLeft(2, '0');
            final FinalSecond = FinalTime.second.toString().padLeft(2, '0');
            x = '$FinalHour$FinalMinute$FinalSecond';
            final FinalDay = FinalTime.day;
            final FinalMonth = FinalTime.month;
            final FinalYear = FinalTime.year;
            var last_time =
                '$FinalHour:$FinalMinute:$FinalSecond  $FinalDay/$FinalMonth/$FinalYear';
            int SecondTime = int.parse(x);
            int timeStayed = SecondTime - firstTime;
            ForAudio NewforAudio = ForAudio();

            for (i = 0; i < 100; i++) {
              try {
                times.add(forVideo.Time_spent_every_once[i]);
                NumperOfEnters++;
              } catch (e) {
                times.add(timeStayed);
                break;
              }
            }

            NewforAudio.NumberOfVisitedPage = forVideo.NumberOfVisitedPage + 1;
            NewforAudio.TimeSpendInPage =
                forVideo.TimeSpendInPage + (SecondTime - firstTime);
            db.updateStudentBehavior(
                NewforAudio.TimeSpendInPage,
                NewforAudio.NumberOfVisitedPage,
                "video",
                std.id,
                level.id,
                topic.id,
                times,
                last_time);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => types(std, level, topic, false)));
            chewieController!.pause();
          },
        ),
      ),
      body: playerWidget(),
    );
  }
}
