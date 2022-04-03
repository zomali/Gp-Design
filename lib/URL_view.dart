import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gp/classes/classes.dart';
class url_view extends StatefulWidget {
  final List<URL_> url;
  url_view(this.url);
  @override _url_view createState() => _url_view(url);
}
class _url_view extends State<url_view> {
  List<URL_> url;
  _url_view(this.url);
  
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
        itemCount: url.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              launch(url[index].url);
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
                          url[index].title,
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