import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class url_view extends StatefulWidget {
  @override _url_view createState() => _url_view();
}
class _url_view extends State<url_view> {
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        // App Bar
        title: Text(
          "URL Of Topic",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: urlList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              launch(urlList[index]);
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