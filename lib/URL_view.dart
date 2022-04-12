import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gp/classes/classes.dart';
import 'classes/student.dart';
import 'classes/studentBehavior.dart';

class url_view extends StatefulWidget {
  final student std;
  final List<URL_> urls;
  final int LevelNumber;
  final int TopicNumber;

  url_view(this.std, this.urls, this.LevelNumber, this.TopicNumber);
  @override _url_view createState() => _url_view(std, urls, LevelNumber, TopicNumber);
}
class _url_view extends State<url_view> {
  /*
  var urlList = [
    "https://www.w3schools.com/cpp/cpp_variables.asp",
    "https://www.geeksforgeeks.org/variables-in-c/",
    "https://www.geeksforgeeks.org/constants-in-c-cpp/",
    "https://www.cplusplus.com/doc/tutorial/constants/",
  ];
  var titleList = [
    "W3schools",
    "W3schools",
    "W3schools",
    "W3schools",
  ];
  */
  student std;
  List<URL_> urls;
  int LevelNumber;
  int TopicNumber;
  _url_view(this.std, this.urls, this.LevelNumber, this.TopicNumber);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        // App Bar
        title: Text(
          "topic name",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              launch(urls[index].url);
            },
            // Card Which Holds Layout Of ListView Item
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 110,
                    height: 110,
                    child:Image.asset('proj_images/url.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          urls[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future OpenBrowserURL({
    required String url,

  })async{
    if(await canLaunch(url))
    {
      await launch(url);
    }
    else
    {
      //throw"can't open the url";
    }
  }
}