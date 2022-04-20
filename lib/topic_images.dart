import 'package:flutter/material.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:gp/classes/classes.dart';

import 'DatabaseManager.dart';

class image_view extends StatefulWidget {
  final student std;
  final List<Image_> image_;
  final ForImage forImage;
  final Level_ level;
  final Topic_ topic;
  image_view(this.std, this.image_, this.forImage, this.level, this.topic);
  @override
  _image_view createState() => _image_view(std, image_, forImage, level, topic);
}

class _image_view extends State<image_view> {
  student std;
  List<Image_> image_;
  ForImage forImage;
  Level_ level;
  Topic_ topic;
  _image_view(this.std, this.image_, this.forImage, this.level, this.topic);
  DatabaseManager db = DatabaseManager();

  int NumperOfEnters = 0;
  List<int> times = [];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    DateTime initialTime = DateTime.now();
    final initialHour = initialTime.hour.toString().padLeft(2, '0');
    final initialMinute = initialTime.minute.toString().padLeft(2, '0');
    final initialSecond = initialTime.second.toString().padLeft(2, '0');

    String x = '$initialHour$initialMinute$initialSecond';
    int firstTime = int.parse(x);
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        // App Bar
        title: Text(
          topic.name,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          color: Colors.white,
          onPressed: () {
            try {
              for (int i = 1; i < 5; i++) {
                forImage.Time_spent_every_once[i];
                NumperOfEnters++;
              }
            } catch (e) {}

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
            ForImage NewforImage = ForImage();
            NewforImage.NumberOfVisitedPage = forImage.NumberOfVisitedPage + 1;
            NewforImage.TimeSpendInPage =
                forImage.TimeSpendInPage + (SecondTime - firstTime);
            for (i = 0; i < 100; i++) {
              try {
                times.add(forImage.Time_spent_every_once[i]);
                NumperOfEnters++;
              } catch (e) {
                times.add(timeStayed);
                break;
              }
            }
            db.updateStudentBehavior(
                NewforImage.TimeSpendInPage,
                NewforImage.NumberOfVisitedPage,
                "image",
                std.id,
                level.id,
                topic.id,
                times,
                last_time);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => levels_view(std)));
            // _selectedIndex-=2;
          },
        ),
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: image_.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              showDialogFunc(context, image_[index].URL, image_[index].title,
                  image_[index].source);
            },
            // Card Which Holds Layout Of ListView Item
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                      width: 110,
                      height: 110,
                      child: Image.network(image_[index].URL)),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        image_[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        child: Text(
                          image_[index].source,
                          maxLines: 3,
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// This is a block of Model Dialog
showDialogFunc(context, img, title, desc) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(5),
            height: 620,
            width: MediaQuery.of(context).size.width * 2.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    img,
                    width: 500,
                    height: 500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
