import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gp/classes/classes.dart';
import 'L_types.dart';
import 'classes/student.dart';
import 'classes/studentBehavior.dart';

class url_view extends StatefulWidget {
  final student std;
  final List<URL_> urls;
  final Level_ level;
  final Topic_ topic;

  url_view(this.std, this.urls, this.level, this.topic);
  @override
  _url_view createState() => _url_view(std, urls, level, topic);
}

class _url_view extends State<url_view> {
  student std;
  List<URL_> urls;
  Level_ level;
  Topic_ topic;
  _url_view(this.std, this.urls, this.level, this.topic);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
          // App Bar
          title: Text(
            topic.name,
            style: TextStyle(color: Colors.blue),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => types(std, level, topic, false)));
              })),
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
                    child: Image.asset('proj_images/url.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: urls[index].title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
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
  }) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //throw"can't open the url";
    }
  }
}
