import 'package:flutter/material.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';

import 'DatabaseManager.dart';
import 'Levels.dart';

class image_view extends StatefulWidget {
  final student std;
  final ForImage forImage;
  final int LevelNumber;
  final int TopicNumber;
  image_view(this.std, this.forImage, this.LevelNumber, this.TopicNumber);
  @override
  _image_view createState() =>
      _image_view(std, forImage, LevelNumber, TopicNumber);
}

class _image_view extends State<image_view> {
  student std;
  ForImage forImage;
  int LevelNumber;
  int TopicNumber;
  _image_view(this.std, this.forImage, this.LevelNumber, this.TopicNumber);
  DatabaseManager db = DatabaseManager();
  int NumperOfEnters = 0;
  List<int> times = [];
  int i = 0;
  var titleList = [
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
    "Variable in C++",
  ];

  var srcList = [
    "geeksforgeeks",
    "geeksforgeeks",
    "geeksforgeeks",
    "geeksforgeeks",
    "geeksforgeeks",
    "geeksforgeeks",
    "geeksforgeeks",
  ];

  var imgList = [
    "assets/images/img1.jpg",
    "assets/images/img2.jpg",
    "assets/images/img3.jpg",
    "assets/images/img4.jpg",
    "assets/images/img5.jpg",
    "assets/images/img6.jpg",
    "assets/images/img7.jpg"
  ];

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
          "Images Of Topic",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
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
                LevelNumber,
                TopicNumber,
                times);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => levels_view(std)));
            // _selectedIndex-=2;
          },
        ),
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              showDialogFunc(
                  context, imgList[index], titleList[index], srcList[index]);
            },
            // Card Which Holds Layout Of ListView Item
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                      width: 110,
                      height: 110,
                      child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2F1.1.2.jpg?alt=media&token=d703e865-5f01-40ef-a493-9bb3bce9cf21')),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        titleList[index],
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
                          srcList[index],
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
                    'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2F1.1.2.jpg?alt=media&token=d703e865-5f01-40ef-a493-9bb3bce9cf21',
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
